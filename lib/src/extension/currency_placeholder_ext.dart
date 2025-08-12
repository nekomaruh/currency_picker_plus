import '../../currency_picker_plus.dart';

extension CurrencyPlaceholder on Currency {
  /// Generates a placeholder string like "0.00" or "€ 0,00" based on the currency configuration.
  ///
  /// [showSymbol]: Whether to include the currency symbol in the placeholder. Defaults to true.
  /// [forceSymbolSpace]: If true, forces a space between the amount and symbol,
  /// ignoring the currency's own setting. Defaults to false.
  ///
  /// Returns a formatted string suitable for input placeholders.
  String emptyPlaceholder({bool showSymbol = false, bool forceSymbolSpace = false}) {
    // Build the numeric part like "0", "0.00", or "0,00" depending on decimalSeparator and decimalDigits
    final decimalPart = decimalDigits > 0
        ? decimalSeparator + ('0' * decimalDigits)
        : '';

    final amount = '0$decimalPart';

    if (!showSymbol) {
      return amount;
    }

    final space = (forceSymbolSpace || spaceBetweenAmountAndSymbol) ? ' ' : '';

    if (symbolOnLeft) {
      return '$symbol$space$amount';
    } else {
      return '$amount$space$symbol';
    }
  }
}
