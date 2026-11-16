import '../../enums/currency.dart';
import '../../enums/service_category.dart';

class VoiceParsedServiceLog {
  final String rawTranscript;
  final String title;
  final ServiceCategory category;
  final int odometerKm;
  final double totalCost;
  final Currency currency;
  final String mechanicName;

  const VoiceParsedServiceLog({
    required this.rawTranscript,
    required this.title,
    required this.category,
    required this.odometerKm,
    required this.totalCost,
    required this.currency,
    required this.mechanicName,
  });

  bool get hasMeaningfulInput => rawTranscript.trim().isNotEmpty;
}

class VoiceLogParser {
  VoiceLogParser._();

  static VoiceParsedServiceLog parse(
    String transcript, {
    int defaultOdometerKm = 184250,
    Currency defaultCurrency = Currency.amd,
  }) {
    final trimmed = transcript.trim();
    if (trimmed.isEmpty) {
      return VoiceParsedServiceLog(
        rawTranscript: '',
        title: 'General Maintenance Service',
        category: ServiceCategory.oilFilter,
        odometerKm: defaultOdometerKm,
        totalCost: 0,
        currency: defaultCurrency,
        mechanicName: 'Private Workshop',
      );
    }

    final lower = trimmed.toLowerCase();

    // 1. Detect ServiceCategory
    final category = _detectCategory(lower);

    // 2. Detect Currency
    final currency = _detectCurrency(lower, defaultCurrency);

    // 3. Detect Odometer & Cost
    final numbers = _extractNumbersWithContext(lower);
    final odometerKm = numbers.odometer ?? defaultOdometerKm;
    final totalCost = numbers.cost ?? 0.0;

    // 4. Detect Mechanic / Facility Name
    final mechanicName = _detectMechanic(trimmed) ?? 'Private Workshop';

    // 5. Extract clean Service Title
    final title = _extractCleanTitle(trimmed, category);

    return VoiceParsedServiceLog(
      rawTranscript: trimmed,
      title: title,
      category: category,
      odometerKm: odometerKm,
      totalCost: totalCost,
      currency: currency,
      mechanicName: mechanicName,
    );
  }

  static ServiceCategory _detectCategory(String lower) {
    if (RegExp(
      r'(oil|filter|lube|liqui|mobil|castrol|shell|масл|фильтр|յուղ|ֆիլտր)',
    ).hasMatch(lower)) {
      return ServiceCategory.oilFilter;
    }
    if (RegExp(
      r'(brake|pad|rotor|disc|caliper|brembo|тормоз|колодк|диск|արգելակ|կալոդկա)',
    ).hasMatch(lower)) {
      return ServiceCategory.brakes;
    }
    if (RegExp(
      r'(suspension|shock|strut|arm|joint|bushing|tie rod|wheel bearing|хоis|ходов|амортизатор|рычаг|шаров|шрус|խոդովոյ|ամորտիզատոր)',
    ).hasMatch(lower)) {
      return ServiceCategory.suspension;
    }
    if (RegExp(
      r'(transmission|gearbox|clutch|atf|zf|коробк|акпп|кпп|сцеплен|կարոբկա|փոխանցման)',
    ).hasMatch(lower)) {
      return ServiceCategory.transmission;
    }
    if (RegExp(
      r'(engine|timing|belt|chain|gasket|radiator|coolant|pump|turbo|injector|battery|alternator|starter|spark|sensor|двигател|мотор|грм|ремен|цеп|радиатор|антифриз|аккумулятор|генератор|стартер|свеч|датчик|շարժիչ|մատոռ|ակումլյատոր|մարտկոց)',
    ).hasMatch(lower)) {
      return ServiceCategory.engine;
    }
    return ServiceCategory.suspension;
  }

  static Currency _detectCurrency(String lower, Currency fallback) {
    if (RegExp(r'(\$|usd|dollar|доллар|դոլար)').hasMatch(lower)) {
      return Currency.usd;
    }
    if (RegExp(r'(₽|rub|ruble|руб|ռուբլի)').hasMatch(lower)) {
      return Currency.rub;
    }
    if (RegExp(r'(֏|amd|dram|драм|դրամ)').hasMatch(lower)) {
      return Currency.amd;
    }
    return fallback;
  }

  static ({int? odometer, double? cost}) _extractNumbersWithContext(
    String lower,
  ) {
    int? odometer;
    double? cost;

    // Normalize formatted numbers like "185,000" or "45 000" -> "185000", "45000"
    final normalized = lower
        .replaceAllMapped(
          RegExp(r'(\d)[,\s](\d{3})\b'),
          (m) => '${m[1]}${m[2]}',
        )
        .replaceAllMapped(
          RegExp(r'(\d+)\s*(k|thousand|тыс|тысяч|հազար)\b'),
          (m) => '${(int.tryParse(m[1]!) ?? 0) * 1000}',
        );

    // Explicit odometer match: e.g. "185000 km", "at 185000 kilometers", "185000 км", "185000 կմ"
    final odoMatch = RegExp(
      r'(\d{4,6})\s*(km|kilometer|kilometers|miles|mi|км|километр|կմ)\b',
    ).firstMatch(normalized);
    if (odoMatch != null) {
      odometer = int.tryParse(odoMatch.group(1)!);
    }

    // Explicit cost match with currency word/symbol
    final costBeforeCurrency = RegExp(
      r'(\d+(?:\.\d+)?)\s*(amd|dram|դրամ|драм|usd|dollars?|\$|доллар|դոլար|rub|rubles?|₽|руб)',
    ).firstMatch(normalized);
    final costAfterSymbol = RegExp(
      r'(\$|֏|₽)\s*(\d+(?:\.\d+)?)',
    ).firstMatch(normalized);
    final costAfterFor = RegExp(
      r'\b(?:for|cost|paid|price|за|արժեքը|վճարեցի)\s+(\d{2,7})\b',
    ).firstMatch(normalized);

    if (costBeforeCurrency != null) {
      cost = double.tryParse(costBeforeCurrency.group(1)!);
    } else if (costAfterSymbol != null) {
      cost = double.tryParse(costAfterSymbol.group(2)!);
    } else if (costAfterFor != null) {
      cost = double.tryParse(costAfterFor.group(1)!);
    }

    // Fallback: inspect remaining standalone numbers
    final allNumbers = RegExp(r'\b(\d{2,7})\b')
        .allMatches(normalized)
        .map((m) => int.tryParse(m.group(1)!))
        .whereType<int>()
        .toList();

    for (final num in allNumbers) {
      if (odometer == null && num >= 50000 && num <= 600000 && num != cost?.toInt()) {
        odometer = num;
      } else if (cost == null && num != odometer && num >= 50 && num <= 2000000) {
        cost = num.toDouble();
      }
    }

    return (odometer: odometer, cost: cost);
  }

  static String? _detectMechanic(String text) {
    final patterns = [
      RegExp(
        r'\b(?:with|by|at|master|varpet|mechanic|workshop|у мастера|у|վարպետ)\s+([A-Za-zА-Яа-яԱ-Ֆա-ֆ0-9][A-Za-zА-Яа-яԱ-Ֆա-ֆ0-9\s]{1,24}?)(?=\s+(?:for|at|\d|km|dram|amd|\$)|$)',
        caseSensitive: false,
      ),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        final candidate = match.group(1)?.trim() ?? '';
        if (candidate.isNotEmpty &&
            !RegExp(r'^\d+$').hasMatch(candidate) &&
            !RegExp(r'^(km|dram|amd|usd)$', caseSensitive: false)
                .hasMatch(candidate)) {
          return _capitalizeWords(candidate);
        }
      }
    }
    return null;
  }

  static String _extractCleanTitle(String raw, ServiceCategory category) {
    var cleaned = raw
        // Strip leading action verbs
        .replaceFirst(
          RegExp(
            r'^(i\s+)?(changed|replaced|fixed|repaired|serviced|installed|did|поменял|заменил|сделал|փոխեցի|վերանորոգեցի)\s+(the\s+|my\s+)?',
            caseSensitive: false,
          ),
          '',
        )
        // Strip odometer / cost / mechanic trailing segments
        .replaceAll(
          RegExp(
            r'\b(at|on|for|cost|paid|with|by|master|varpet)\s+\d[\d,\s]*(km|kilometers?|dram|amd|usd|rub|\$|֏|₽|k|thousand)?.*$',
            caseSensitive: false,
          ),
          '',
        )
        .replaceAll(
          RegExp(
            r'\b\d[\d,\s]*(km|kilometers?|км|կմ|dram|amd|դրամ|драм|usd|dollars?|\$|rub|₽|k|thousand|հազար|тысяч)\b.*$',
            caseSensitive: false,
          ),
          '',
        )
        .trim();

    cleaned = cleaned.replaceAll(RegExp(r'[,.;:\-]+$'), '').trim();

    if (cleaned.length < 3) {
      return '${category.enName} Service';
    }
    return _capitalizeWords(cleaned);
  }

  static String _capitalizeWords(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed[0].toUpperCase() + trimmed.substring(1);
  }
}
