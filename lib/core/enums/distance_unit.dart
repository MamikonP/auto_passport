enum DistanceUnit {
  km('km', 1.0),
  miles('miles', 1.609344);

  final String label;
  final double rateToKm;
  const DistanceUnit(this.label, this.rateToKm);

  double convert(num distance, {required DistanceUnit to}) {
    if (this == to) return distance.toDouble();
    final distanceInKm = distance * rateToKm;
    return distanceInKm / to.rateToKm;
  }

  int convertToInt(num distance, {required DistanceUnit to}) =>
      convert(distance, to: to).round();

  String format(num distance) {
    final formatted = distance.round().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '$formatted $label';
  }

  static DistanceUnit fromString(String? val) {
    return DistanceUnit.values.firstWhere(
      (d) =>
          d.name.toLowerCase() == val?.toLowerCase() ||
          d.label.toLowerCase() == val?.toLowerCase(),
      orElse: () => DistanceUnit.km,
    );
  }
}
