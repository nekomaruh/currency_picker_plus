import '../data/currency.dart';

extension CurrencyRawFormatter on Currency {
  /// Formats a raw numeric string according to the Currency settings.
  ///
  /// Parameters:
  /// - [rawValue]: the unformatted number string, e.g., "3832.83".
  /// - [showSymbol]: whether to display the currency symbol.
  /// - [forceSymbolSpace]: forces a space between symbol and number.
  /// - [maxDecimals]: optional override for the number of decimal digits.
  ///
  /// Returns a formatted string, e.g., "$3,832.83" or "₩3,832".
  String format({
    required String rawValue,
    bool showSymbol = false,
    bool forceSymbolSpace = false,
    int? maxDecimals,
  }) {
    // Empty input: return zero with optional symbol
    if (rawValue.isEmpty) {
      String formatted = '0';
      if (showSymbol) {
        final space = (forceSymbolSpace || spaceBetweenAmountAndSymbol)
            ? '\u00A0'
            : '';
        formatted = symbolOnLeft
            ? '$symbol$space$formatted'
            : '$formatted$space$symbol';
      }
      return formatted;
    }

    // Detect negative numbers
    final isNegative = rawValue.startsWith('-');
    final unsignedValue = isNegative ? rawValue.substring(1) : rawValue;

    // Split integer and decimal parts
    final parts = unsignedValue.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Determine the number of decimals to show
    final decimals = maxDecimals != null
        ? decimalDigits.clamp(0, maxDecimals)
        : decimalDigits;

    // Truncate or pad decimal part as needed
    if (decimals > 0) {
      if (decimalPart.length > decimals) {
        decimalPart = decimalPart.substring(0, decimals);
      } else {
        decimalPart = decimalPart.padRight(decimals, '0');
      }
    } else {
      decimalPart = '';
    }

    // Add thousands separators using regex (efficient, no loop)
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    integerPart = integerPart.replaceAllMapped(reg, (m) => thousandsSeparator);

    // Combine integer and decimal parts
    String formatted = decimalPart.isNotEmpty
        ? '$integerPart$decimalSeparator$decimalPart'
        : integerPart;

    // Re-add negative sign if needed
    if (isNegative) {
      formatted = '-$formatted';
    }

    // Add currency symbol if requested
    if (showSymbol) {
      final space = (forceSymbolSpace || spaceBetweenAmountAndSymbol)
          ? '\u00A0'
          : '';
      formatted = symbolOnLeft
          ? '$symbol$space$formatted'
          : '$formatted$space$symbol';
    }

    return formatted;
  }
}
