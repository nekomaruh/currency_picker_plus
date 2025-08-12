import '../../currency_picker_plus.dart';

CurrencyFormatter formatterFromCurrency({
  required Currency currency,
  bool showSymbol = false,
}) {
  return CurrencyFormatter.currency(
    locale: currency.locale,
    symbol: currency.symbol,
    decimalDigits: currency.decimalDigits,
    decimalSeparator: currency.decimalSeparator,
    thousandsSeparator: currency.thousandsSeparator,
    showSymbol: showSymbol,
    symbolOnLeft: currency.symbolOnLeft,
    showSymbolSpace: currency.spaceBetweenAmountAndSymbol,
  );
}
