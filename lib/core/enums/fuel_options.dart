enum FuelOptions {
  petrol(value: 'Petrol (Gasoline)'),
  diesel(value: 'Diesel'),
  electric(value: 'Electric (EV)'),
  hybrid(value: 'Hybrid (HEV / PHEV)'),
  gas(value: 'Gas (LPG / CNG)');

  final String value;

  const FuelOptions({required this.value});
}
