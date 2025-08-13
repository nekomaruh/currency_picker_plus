import '../../currency_picker_plus.dart';

CurrencyFormatter formatterFromCurrency({
  required Currency currency,
  bool showSymbol = false,
  int? maxDecimals,
}) {
  int decimals = maxDecimals != null
      ? currency.decimalDigits.clamp(0, maxDecimals)
      : currency.decimalDigits;

  return CurrencyFormatter.currency(
    locale: currency.locale,
    symbol: currency.symbol,
    decimalDigits: decimals,
    decimalSeparator: currency.decimalSeparator,
    thousandsSeparator: currency.thousandsSeparator,
    showSymbol: showSymbol,
    symbolOnLeft: currency.symbolOnLeft,
    showSymbolSpace: currency.spaceBetweenAmountAndSymbol,
  );
}
