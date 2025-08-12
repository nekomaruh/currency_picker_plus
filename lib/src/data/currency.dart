class Currency {
  final String code;
  final String name;
  final String symbol;
  final String flag;
  final int number;
  final int decimalDigits;
  final String namePlural;
  final String decimalSeparator;
  final String thousandsSeparator;
  final bool symbolOnLeft;
  final bool spaceBetweenAmountAndSymbol;
  final String locale;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flag,
    required this.number,
    required this.decimalDigits,
    required this.namePlural,
    required this.decimalSeparator,
    required this.thousandsSeparator,
    required this.symbolOnLeft,
    required this.spaceBetweenAmountAndSymbol,
    required this.locale,
  });
}
