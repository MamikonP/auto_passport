enum ServiceCategory {
  suspension('Suspension & Steering', 'Կախոց'),
  brakes('Brakes', 'Արգելակներ'),
  oilFilter('Oil & Filter', 'Յուղ և Զտիչներ'),
  engine('Engine', 'Շարժիչ'),
  transmission('Transmission', 'Փոխանցման տուփ');

  final String enName;
  final String hyName;
  const ServiceCategory(this.enName, this.hyName);

  static ServiceCategory fromString(String? val) {
    return ServiceCategory.values.firstWhere(
      (c) => c.name.toLowerCase() == val?.toLowerCase() || c.enName.toLowerCase() == val?.toLowerCase(),
      orElse: () => ServiceCategory.oilFilter,
    );
  }
}
