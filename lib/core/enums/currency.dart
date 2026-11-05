enum Currency {
  amd('֏', 'AMD'),
  usd('\$', 'USD'),
  eur('€', 'EUR'),
  rub('₽', 'RUB');

  final String symbol;
  final String code;
  const Currency(this.symbol, this.code);

  static Currency fromString(String? val) {
    return Currency.values.firstWhere(
      (c) => c.name.toLowerCase() == val?.toLowerCase() || c.code.toLowerCase() == val?.toLowerCase(),
      orElse: () => Currency.amd,
    );
  }
}
