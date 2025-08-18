import '../data/currency.dart';

extension CurrencyPlaceholder on Currency {
  /// Generates a placeholder string like "0.00" or "€ 0,00" based on the currency configuration.
  ///
  /// [showSymbol]: Whether to include the currency symbol in the placeholder. Defaults to false.
  /// [forceSymbolSpace]: If true, forces a space between the amount and symbol,
  /// ignoring the currency's own setting. Defaults to false.
  /// [maxDecimals]: Optional maximum number of decimals to show.
  ///
  /// Returns a formatted string suitable for input placeholders.
  String emptyPlaceholder({
    bool showSymbol = false,
    bool forceSymbolSpace = false,
    int? maxDecimals,
  }) {
    // Decimal amount
    final decimals = maxDecimals != null
        ? decimalDigits.clamp(0, maxDecimals)
        : decimalDigits;

    // Decimal part as "0.00" o "0,00"
    final decimalPart = decimals > 0 ? decimalSeparator + ('0' * decimals) : '';

    final amount = '0$decimalPart';

    if (!showSymbol) {
      return amount;
    }

    final space = (forceSymbolSpace || spaceBetweenAmountAndSymbol)
        ? '\u00A0'
        : '';

    if (symbolOnLeft) {
      return '$symbol$space$amount';
    } else {
      return '$amount$space$symbol';
    }
  }
}
