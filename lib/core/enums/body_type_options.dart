enum BodyTypeOptions {
  sedan(value: 'Sedan'),
  suv(value: 'SUV / Crossover'),
  hatchback(value: 'Hatchback'),
  coupe(value: 'Coupe'),
  wagon(value: 'Wagon / Estate'),
  convertible(value: 'Convertible / Cabriolet'),
  pickup(value: 'Pickup Truck'),
  minivan(value: 'Minivan / Van');

  final String value;

  const BodyTypeOptions({required this.value});
}

