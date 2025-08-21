import 'package:decimal/decimal.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  factory CurrencyFormatter(
    NumberFormat format, {
    bool enableNegative = true,
    InputDirection inputDirection = InputDirection.right,
    Decimal? minValue,
    Decimal? maxValue,
    Function(String)? onChange,
    bool showSymbol = false,
    String? decimalSeparator,
    String? thousandsSeparator,
    bool? symbolOnLeft,
    bool? showSymbolSpace,
  }) {
    return CurrencyFormatter._(
      format,
      enableNegative,
      inputDirection,
      minValue,
      maxValue,
      onChange,
      showSymbol: showSymbol,
      decimalSeparator: decimalSeparator ?? format.symbols.DECIMAL_SEP,
      thousandsSeparator: thousandsSeparator ?? format.symbols.GROUP_SEP,
      symbolOnLeft: symbolOnLeft,
      showSymbolSpace: showSymbolSpace,
    );
  }

  CurrencyFormatter._(
    this.format,
    this.enableNegative,
    this.inputDirection,
    this.minValue,
    this.maxValue,
    this.onChange, {
    this.showSymbol = true,
    String? decimalSeparator,
    String? thousandsSeparator,
    bool? symbolOnLeft,
    bool? showSymbolSpace,
  }) : _decimalSeparator = decimalSeparator ?? format.symbols.DECIMAL_SEP,
       _thousandsSeparator = thousandsSeparator ?? format.symbols.GROUP_SEP,
       _symbolOnLeft =
           symbolOnLeft ??
           !(format.currencySymbol.isNotEmpty &&
               format.currencySymbol.codeUnitAt(0) >= 48 &&
               format.currencySymbol.codeUnitAt(0) <= 57),
       _showSymbolSpace = showSymbolSpace ?? true;

  factory CurrencyFormatter.currency({
    String? locale,
    String? name,
    String? symbol,
    int? decimalDigits,
    String? customPattern,
    bool turnOffGrouping = false,
    bool enableNegative = true,
    InputDirection inputDirection = InputDirection.right,
    Decimal? minValue,
    Decimal? maxValue,
    Function(String)? onChange,
    bool showSymbol = false,
    String? decimalSeparator,
    String? thousandsSeparator,
    bool? symbolOnLeft,
    bool? showSymbolSpace,
  }) {
    final NumberFormat format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );

    if (turnOffGrouping) {
      format.turnOffGrouping();
    }

    return CurrencyFormatter._(
      format,
      enableNegative,
      inputDirection,
      minValue,
      maxValue,
      onChange,
      showSymbol: showSymbol,
      decimalSeparator: decimalSeparator,
      thousandsSeparator: thousandsSeparator,
      symbolOnLeft: symbolOnLeft,
      showSymbolSpace: showSymbolSpace,
    );
  }

  factory CurrencyFormatter.simpleCurrency({
    String? locale,
    String? name,
    int? decimalDigits,
    bool turnOffGrouping = false,
    bool enableNegative = true,
    InputDirection inputDirection = InputDirection.right,
    Decimal? minValue,
    Decimal? maxValue,
    Function(String)? onChange,
    bool showSymbol = true,
    String? decimalSeparator,
    String? thousandsSeparator,
    bool? symbolOnLeft,
    bool? showSymbolSpace,
  }) {
    final NumberFormat format = NumberFormat.simpleCurrency(
      locale: locale,
      name: name,
      decimalDigits: decimalDigits,
    );

    if (turnOffGrouping) {
      format.turnOffGrouping();
    }

    return CurrencyFormatter._(
      format,
      enableNegative,
      inputDirection,
      minValue,
      maxValue,
      onChange,
      showSymbol: showSymbol,
      decimalSeparator: decimalSeparator,
      thousandsSeparator: thousandsSeparator,
      symbolOnLeft: symbolOnLeft,
      showSymbolSpace: showSymbolSpace,
    );
  }

  final NumberFormat format;
  final bool enableNegative;
  final InputDirection inputDirection;
  final Decimal? minValue;
  final Decimal? maxValue;
  final Function(String)? onChange;
  final bool showSymbol;

  final String _decimalSeparator;
  final String _thousandsSeparator;
  final bool _symbolOnLeft;
  final bool _showSymbolSpace;

  Decimal _newNum = Decimal.zero;
  String _newString = '';
  bool _isNegative = false;

  NumberFormat get numberFormat => format;

  void _formatter(String newText) {
    _newNum = _parseStrToDecimal(newText);

    final rawStr = _newNum.toStringAsFixed(format.decimalDigits ?? 0);

    final formattedStr = formatDecimalStringWithSeparators(
      rawStr,
      decimalDigits: format.decimalDigits ?? 0,
      thousandSeparator: _thousandsSeparator,
      decimalSeparator: _decimalSeparator,
    );

    final space = _showSymbolSpace ? ' ' : '';

    if (showSymbol) {
      if (_symbolOnLeft) {
        _newString =
            (_isNegative ? '-' : '') +
            format.currencySymbol +
            space +
            formattedStr.trim();
      } else {
        _newString =
            (_isNegative ? '-' : '') +
            formattedStr.trim() +
            space +
            format.currencySymbol;
      }
    } else {
      _newString = (_isNegative ? '-' : '') + formattedStr.trim();
    }
  }

  Decimal _parseStrToDecimal(String text) {
    if (text.isEmpty) return Decimal.zero;

    final decimalDigits = format.decimalDigits ?? 0;

    if (decimalDigits == 0) {
      return Decimal.parse(text);
    } else {
      final length = text.length;

      final paddedText = length <= decimalDigits
          ? '0' * (decimalDigits - length + 1) + text
          : text;

      final integerPart = paddedText.substring(
        0,
        paddedText.length - decimalDigits,
      );
      final fractionalPart = paddedText.substring(
        paddedText.length - decimalDigits,
      );
      final combined = '$integerPart.$fractionalPart';

      return Decimal.parse(combined);
    }
  }

  bool _isLessThanMinValue(Decimal value) {
    if (minValue == null) return false;
    return value < minValue!;
  }

  bool _isMoreThanMaxValue(Decimal value) {
    if (maxValue == null) return false;
    return value > maxValue!;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == ' ') {
      return oldValue;
    }

    final bool isLeft = inputDirection == InputDirection.left;
    if (isLeft) {
      if (newValue.text.isEmpty) {
        _newNum = Decimal.zero;
        _newString = '';
        return newValue;
      }

      final List<String> nums = newValue.text.split('.');
      if (nums.length > 2) {
        return oldValue;
      }
      if (nums.length == 2 && (nums[1].length > (format.decimalDigits ?? 2))) {
        return oldValue;
      }
      final Decimal? v = Decimal.tryParse(newValue.text);
      if (v == null) {
        return oldValue;
      }
      if (_isLessThanMinValue(v) || _isMoreThanMaxValue(v)) {
        return oldValue;
      }
      _newNum = v;
      _newString = newValue.text;
      return newValue;
    }

    final bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
        oldValue.text.startsWith(newValue.text);

    if (enableNegative) {
      _isNegative = newValue.text.startsWith('-');
    } else {
      _isNegative = false;
    }

    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      final int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    final Decimal value = _parseStrToDecimal(newText);

    if (_isLessThanMinValue(value) || _isMoreThanMaxValue(value)) {
      return oldValue;
    }

    _formatter(newText);

    if (newText.trim() == '' || newText == '00' || newText == '000') {
      return TextEditingValue(
        text: _isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: _isNegative ? 1 : 0),
      );
    }

    if (onChange != null) {
      onChange!(_newString);
    }

    return TextEditingValue(
      text: _newString,
      selection: TextSelection.collapsed(
        offset: _calculateNewOffset(oldValue, newValue),
      ),
    );
  }

  int _calculateNewOffset(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldOffset = oldValue.selection.baseOffset;
    final diff = _newString.length - oldValue.text.length;
    final newOffset = oldOffset + diff;

    return newOffset.clamp(0, _newString.length);
  }

  static bool _lastCharacterIsDigit(String text) {
    final String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9]').hasMatch(lastChar);
  }

  String getFormattedValue() {
    return _newString;
  }

  String getUnformattedValue() {
    if (_newNum == Decimal.zero) return "0";
    return (_isNegative ? '-' : '') + _newNum.toString();
  }

  Decimal getUnformattedValueDecimal() {
    return _isNegative ? -_newNum : _newNum;
  }

  String formatString(String value) {
    if (enableNegative) {
      _isNegative = value.startsWith('-');
    } else {
      _isNegative = false;
    }

    final String newText = value.replaceAll(RegExp('[^0-9]'), '');
    _formatter(newText);
    return _newString;
  }
}

String formatDecimalStringWithSeparators(
  String numberStr, {
  int decimalDigits = 2,
  String thousandSeparator = ',',
  String decimalSeparator = '.',
}) {
  List<String> parts = numberStr.split('.');

  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? parts[1] : '';

  final buffer = StringBuffer();
  int len = integerPart.length;
  for (int i = 0; i < len; i++) {
    buffer.write(integerPart[i]);
    int posFromRight = len - i - 1;
    if (posFromRight % 3 == 0 && i != len - 1) {
      buffer.write(thousandSeparator);
    }
  }

  String formattedInteger = buffer.toString();

  if (decimalDigits > 0) {
    if (decimalPart.length > decimalDigits) {
      decimalPart = decimalPart.substring(0, decimalDigits);
    } else if (decimalPart.length < decimalDigits) {
      decimalPart = decimalPart.padRight(decimalDigits, '0');
    }
    return '$formattedInteger$decimalSeparator$decimalPart';
  } else {
    return formattedInteger;
  }
}

enum InputDirection { left, right }
