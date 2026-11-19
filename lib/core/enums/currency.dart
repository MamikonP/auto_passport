enum Currency {
  amd('֏', 'AMD', 1.0),
  usd('\$', 'USD', 390.0),
  eur('€', 'EUR', 425.0),
  rub('₽', 'RUB', 4.2);

  final String symbol;
  final String code;
  final double rateToAmd;
  const Currency(this.symbol, this.code, this.rateToAmd);

  double convert(double amount, {required Currency to}) {
    if (this == to) return amount;
    final amountInAmd = amount * rateToAmd;
    return amountInAmd / to.rateToAmd;
  }

  String format(double amount) {
    final isWholeNumber = (amount - amount.roundToDouble()).abs() < 0.01;
    if (this == Currency.amd || this == Currency.rub || isWholeNumber) {
      final intVal = amount.round();
      final formattedInt = intVal.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
      return '$symbol $formattedInt';
    }
    final fixed = amount.toStringAsFixed(2);
    final parts = fixed.split('.');
    final formattedInt = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '$symbol $formattedInt.${parts[1]}';
  }

  static Currency fromString(String? val) {
    return Currency.values.firstWhere(
      (c) =>
          c.name.toLowerCase() == val?.toLowerCase() ||
          c.code.toLowerCase() == val?.toLowerCase(),
      orElse: () => Currency.amd,
    );
  }
}
