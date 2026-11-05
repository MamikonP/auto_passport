enum DistanceUnit {
  km('km'),
  miles('miles');

  final String label;
  const DistanceUnit(this.label);

  static DistanceUnit fromString(String? val) {
    return DistanceUnit.values.firstWhere(
      (d) => d.name.toLowerCase() == val?.toLowerCase() || d.label.toLowerCase() == val?.toLowerCase(),
      orElse: () => DistanceUnit.km,
    );
  }
}
