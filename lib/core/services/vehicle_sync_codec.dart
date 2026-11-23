import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import '../models/vehicle_passport_model.dart';

class VehicleSyncException implements Exception {
  final String message;
  const VehicleSyncException(this.message);

  @override
  String toString() => 'VehicleSyncException: $message';
}

class VehicleSyncPayload {
  final int version;
  final DateTime exportedAt;
  final String? activeVehicleId;
  final List<VehiclePassportModel> vehicles;
  final Set<String> unlockedVehicleIds;

  const VehicleSyncPayload({
    required this.version,
    required this.exportedAt,
    required this.activeVehicleId,
    required this.vehicles,
    this.unlockedVehicleIds = const <String>{},
  });
}

/// Encodes and decodes all vehicles + service records into an opaque,
/// compressed, ChaCha20-encrypted, integrity-checked sync token (`APSYNC1:...`)
/// that cannot be opened or inspected externally as JSON or CSV.
class VehicleSyncCodec {
  VehicleSyncCodec._();

  static const String _prefix = 'APSYNC1:';
  static const int _formatVersion = 1;
  static const List<int> _magic = [0x41, 0x50, 0x53, 0x31]; // 'APS1'
  static const int _nonceLength = 12; // 96-bit ChaCha20 nonce
  static const int _tagLength = 8; // 64-bit keyed integrity tag

  // 256-bit application sync key (32 bytes).
  static final Uint8List _key = Uint8List.fromList(const [
    0x6A, 0x2F, 0x91, 0xC4, 0x58, 0xE3, 0x17, 0xB2,
    0x4D, 0x86, 0x0E, 0xF5, 0x39, 0xA1, 0x7C, 0x62,
    0xD8, 0x45, 0x9B, 0x13, 0xE7, 0x24, 0x8F, 0x5A,
    0xC1, 0x36, 0x70, 0xAD, 0x19, 0xE2, 0x4B, 0x85,
  ]);

  /// Encodes all vehicles into an encrypted, integrity-checked sync string.
  static String encode({
    required List<VehiclePassportModel> vehicles,
    String? activeVehicleId,
    Set<String> unlockedVehicleIds = const <String>{},
  }) {
    final jsonMap = <String, dynamic>{
      'version': _formatVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'activeVehicleId': activeVehicleId,
      'unlockedVehicleIds': unlockedVehicleIds.toList(),
      'vehicles': vehicles.map((v) => v.toJson()).toList(),
    };

    final utf8Bytes = utf8.encode(jsonEncode(jsonMap));
    final compressed = Uint8List.fromList(gzip.encode(utf8Bytes));

    final random = Random.secure();
    final nonce = Uint8List.fromList(
      List<int>.generate(_nonceLength, (_) => random.nextInt(256)),
    );

    final ciphertext = _chaCha20Xor(_key, nonce, 1, compressed);

    final body = BytesBuilder(copy: false)
      ..add(_magic)
      ..addByte(_formatVersion)
      ..add(nonce)
      ..add(ciphertext);
    final bodyBytes = body.toBytes();

    final tag = _computeKeyedTag(_key, nonce, bodyBytes);

    final envelope = BytesBuilder(copy: false)
      ..add(bodyBytes)
      ..add(tag);

    return '$_prefix${base64UrlEncode(envelope.toBytes())}';
  }

  /// Decodes and verifies an encrypted sync string back into vehicles.
  static VehicleSyncPayload decode(String rawInput) {
    final trimmed = rawInput.trim().replaceAll(RegExp(r'\s+'), '');
    if (!trimmed.startsWith(_prefix)) {
      throw const VehicleSyncException('Invalid sync code prefix.');
    }

    final Uint8List envelope;
    try {
      envelope = base64Url.decode(trimmed.substring(_prefix.length));
    } catch (_) {
      throw const VehicleSyncException('Malformed base64 sync payload.');
    }

    final minLength = _magic.length + 1 + _nonceLength + _tagLength + 1;
    if (envelope.length < minLength) {
      throw const VehicleSyncException('Sync payload is truncated.');
    }

    for (int i = 0; i < _magic.length; i++) {
      if (envelope[i] != _magic[i]) {
        throw const VehicleSyncException('Unrecognized sync payload header.');
      }
    }

    final version = envelope[_magic.length];
    if (version != _formatVersion) {
      throw VehicleSyncException('Unsupported sync version: $version.');
    }

    final bodyLength = envelope.length - _tagLength;
    final bodyBytes = envelope.sublist(0, bodyLength);
    final providedTag = envelope.sublist(bodyLength);

    final nonceStart = _magic.length + 1;
    final nonce = envelope.sublist(nonceStart, nonceStart + _nonceLength);
    final expectedTag = _computeKeyedTag(_key, nonce, bodyBytes);

    if (!_constantTimeEquals(providedTag, expectedTag)) {
      throw const VehicleSyncException('Sync payload integrity check failed.');
    }

    final ciphertext = envelope.sublist(nonceStart + _nonceLength, bodyLength);
    final compressed = _chaCha20Xor(_key, nonce, 1, ciphertext);

    final Map<String, dynamic> jsonMap;
    try {
      final utf8Bytes = gzip.decode(compressed);
      final decoded = jsonDecode(utf8.decode(utf8Bytes));
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Root JSON is not an object');
      }
      jsonMap = decoded;
    } catch (_) {
      throw const VehicleSyncException('Failed to decompress or parse payload.');
    }

    try {
      final rawVehicles = jsonMap['vehicles'];
      if (rawVehicles is! List) {
        throw const FormatException('Missing vehicles array');
      }
      final vehicles = rawVehicles
          .map(
            (item) => VehiclePassportModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();

      final rawUnlocked = jsonMap['unlockedVehicleIds'];
      final unlockedIds = rawUnlocked is List
          ? rawUnlocked.map((e) => e.toString()).toSet()
          : <String>{};

      return VehicleSyncPayload(
        version: (jsonMap['version'] as num?)?.toInt() ?? _formatVersion,
        exportedAt:
            DateTime.tryParse(jsonMap['exportedAt'] as String? ?? '') ??
            DateTime.now().toUtc(),
        activeVehicleId: jsonMap['activeVehicleId'] as String?,
        vehicles: vehicles,
        unlockedVehicleIds: unlockedIds,
      );
    } catch (_) {
      throw const VehicleSyncException('Invalid vehicle data inside payload.');
    }
  }

  /// Computes a 64-bit keyed integrity tag using a ChaCha20 block (counter 0)
  /// combined with a 64-bit mixing accumulator over the entire envelope body.
  static Uint8List _computeKeyedTag(
    Uint8List key,
    Uint8List nonce,
    Uint8List data,
  ) {
    final macKey = _chaCha20Block(key, nonce, 0);
    int h1 = _readUint32LE(macKey, 0) ^ 0x9E3779B9;
    int h2 = _readUint32LE(macKey, 4) ^ 0x85EBCA6B;
    final k1 = _readUint32LE(macKey, 8) | 1;
    final k2 = _readUint32LE(macKey, 12) | 1;

    for (int i = 0; i < data.length; i++) {
      h1 = _rotl32((h1 ^ data[i]) * k1 & 0xFFFFFFFF, 13);
      h2 = _rotl32((h2 ^ (data[i] + i)) * k2 & 0xFFFFFFFF, 17);
      h1 = (h1 + h2) & 0xFFFFFFFF;
      h2 = (h2 ^ _rotl32(h1, 7)) & 0xFFFFFFFF;
    }

    h1 ^= data.length & 0xFFFFFFFF;
    h2 ^= _readUint32LE(macKey, 16);
    h1 = _rotl32((h1 * k1) & 0xFFFFFFFF, 15) ^ _readUint32LE(macKey, 20);
    h2 = _rotl32((h2 * k2) & 0xFFFFFFFF, 11) ^ _readUint32LE(macKey, 24);

    final out = Uint8List(_tagLength);
    _writeUint32LE(out, 0, h1);
    _writeUint32LE(out, 4, h2);
    return out;
  }

  static bool _constantTimeEquals(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    int diff = 0;
    for (int i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }

  /// RFC 8439 ChaCha20 stream cipher XOR.
  static Uint8List _chaCha20Xor(
    Uint8List key,
    Uint8List nonce,
    int initialCounter,
    Uint8List input,
  ) {
    final output = Uint8List(input.length);
    int counter = initialCounter;
    int offset = 0;

    while (offset < input.length) {
      final keystream = _chaCha20Block(key, nonce, counter);
      final remaining = input.length - offset;
      final chunk = remaining < 64 ? remaining : 64;
      for (int i = 0; i < chunk; i++) {
        output[offset + i] = input[offset + i] ^ keystream[i];
      }
      offset += chunk;
      counter = (counter + 1) & 0xFFFFFFFF;
    }

    return output;
  }

  static Uint8List _chaCha20Block(
    Uint8List key,
    Uint8List nonce,
    int counter,
  ) {
    final state = Uint32List(16);
    // Constants: "expand 32-byte k"
    state[0] = 0x61707865;
    state[1] = 0x3320646E;
    state[2] = 0x79622D32;
    state[3] = 0x6B206574;

    for (int i = 0; i < 8; i++) {
      state[4 + i] = _readUint32LE(key, i * 4);
    }
    state[12] = counter & 0xFFFFFFFF;
    state[13] = _readUint32LE(nonce, 0);
    state[14] = _readUint32LE(nonce, 4);
    state[15] = _readUint32LE(nonce, 8);

    final working = Uint32List.fromList(state);

    for (int i = 0; i < 10; i++) {
      // Column rounds
      _quarterRound(working, 0, 4, 8, 12);
      _quarterRound(working, 1, 5, 9, 13);
      _quarterRound(working, 2, 6, 10, 14);
      _quarterRound(working, 3, 7, 11, 15);
      // Diagonal rounds
      _quarterRound(working, 0, 5, 10, 15);
      _quarterRound(working, 1, 6, 11, 12);
      _quarterRound(working, 2, 7, 8, 13);
      _quarterRound(working, 3, 4, 9, 14);
    }

    final out = Uint8List(64);
    for (int i = 0; i < 16; i++) {
      final word = (working[i] + state[i]) & 0xFFFFFFFF;
      _writeUint32LE(out, i * 4, word);
    }
    return out;
  }

  static void _quarterRound(Uint32List s, int a, int b, int c, int d) {
    s[a] = (s[a] + s[b]) & 0xFFFFFFFF;
    s[d] = _rotl32(s[d] ^ s[a], 16);
    s[c] = (s[c] + s[d]) & 0xFFFFFFFF;
    s[b] = _rotl32(s[b] ^ s[c], 12);
    s[a] = (s[a] + s[b]) & 0xFFFFFFFF;
    s[d] = _rotl32(s[d] ^ s[a], 8);
    s[c] = (s[c] + s[d]) & 0xFFFFFFFF;
    s[b] = _rotl32(s[b] ^ s[c], 7);
  }

  static int _rotl32(int value, int shift) {
    final v = value & 0xFFFFFFFF;
    return ((v << shift) | (v >>> (32 - shift))) & 0xFFFFFFFF;
  }

  static int _readUint32LE(Uint8List bytes, int offset) {
    return bytes[offset] |
        (bytes[offset + 1] << 8) |
        (bytes[offset + 2] << 16) |
        (bytes[offset + 3] << 24);
  }

  static void _writeUint32LE(Uint8List bytes, int offset, int value) {
    bytes[offset] = value & 0xFF;
    bytes[offset + 1] = (value >> 8) & 0xFF;
    bytes[offset + 2] = (value >> 16) & 0xFF;
    bytes[offset + 3] = (value >> 24) & 0xFF;
  }
}
