import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  late CurrencyFormatter formatter;

  setUp(() {
    formatter = CurrencyFormatter.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
      enableNegative: true,
    );
  });

  group('CurrencyFormatter', () {
    final NumberFormat enUsFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );

    test('should format correctly while entering numbers', () {
      final formatter = CurrencyFormatter(enUsFormat, showSymbol: true);
      TextEditingValue result = const TextEditingValue(text: '');

      result = formatter.formatEditUpdate(
        result,
        const TextEditingValue(text: '1'),
      );
      expect(result.text, '\$ 0.01');

      result = formatter.formatEditUpdate(
        result,
        const TextEditingValue(text: '12'),
      );
      expect(result.text, '\$ 0.12');

      result = formatter.formatEditUpdate(
        result,
        const TextEditingValue(text: '123'),
      );
      expect(result.text, '\$ 1.23');

      result = formatter.formatEditUpdate(
        result,
        const TextEditingValue(text: '1234'),
      );
      expect(result.text, '\$ 12.34');

      result = formatter.formatEditUpdate(
        result,
        const TextEditingValue(text: '123456'),
      );
      expect(result.text, '\$ 1,234.56');
    });

    test('should handle backspace correctly', () {
      final formatter = CurrencyFormatter(enUsFormat, showSymbol: true);
      TextEditingValue initialValue = const TextEditingValue(
        text: '\$ 1,234.56',
      );
      TextEditingValue result = const TextEditingValue(text: '');

      result = formatter.formatEditUpdate(
        initialValue,
        const TextEditingValue(text: '\$ 1,234.5'),
      );
      expect(result.text, '\$ 123.45');

      result = formatter.formatEditUpdate(
        result,
        const TextEditingValue(text: '\$ 123.4'),
      );
      expect(result.text, '\$ 12.34');
    });

    test('should return the right value without formatting', () {
      final formatter = CurrencyFormatter(enUsFormat, showSymbol: true);
      formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '123456'),
      );

      expect(formatter.getUnformattedValue(), '1234.56');
    });

    group('InputDirection.left', () {
      test('should accept direct entry of numbers', () {
        final formatter = CurrencyFormatter.currency(
          locale: 'en_US',
          inputDirection: InputDirection.left,
        );
        TextEditingValue result = const TextEditingValue(text: '');

        result = formatter.formatEditUpdate(
          result,
          const TextEditingValue(text: '123.45'),
        );
        expect(result.text, '123.45');

        expect(formatter.getUnformattedValueDecimal(), Decimal.parse('123.45'));
      });

      test('should ignore non-numeric characters', () {
        final formatter = CurrencyFormatter.currency(
          locale: 'en_US',
          inputDirection: InputDirection.left,
        );
        TextEditingValue initialValue = const TextEditingValue(text: '123.45');

        final result = formatter.formatEditUpdate(
          initialValue,
          const TextEditingValue(text: '123.45.6'),
        );
        expect(result.text, initialValue.text);
      });
    });

    test('should ignore values outside the specified range', () {
      final formatter = CurrencyFormatter.currency(
        locale: 'en_US',
        decimalDigits: 2,
        minValue: Decimal.fromInt(10),
        maxValue: Decimal.fromInt(100),
      );

      final oldValue = const TextEditingValue(text: '10.00');
      final newValueBajo = const TextEditingValue(text: '5');
      final resultBajo = formatter.formatEditUpdate(oldValue, newValueBajo);
      expect(resultBajo.text, oldValue.text);

      final newValueAlto = const TextEditingValue(text: '101');
      final resultAlto = formatter.formatEditUpdate(oldValue, newValueAlto);
      expect(resultAlto.text, oldValue.text);
    });

    test('should ignore negative numbers if enableNegative is true', () {
      final formatter = CurrencyFormatter.currency(
        locale: 'en_US',
        decimalDigits: 2,
        enableNegative: true,
      );

      final oldValue = const TextEditingValue(text: '');
      final newValue = const TextEditingValue(text: '-5');
      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text.startsWith('-'), isTrue);
    });

    test('should ignore negative numbers if enableNegative is false', () {
      final formatter = CurrencyFormatter.currency(
        locale: 'en_US',
        decimalDigits: 2,
        enableNegative: false,
      );

      final oldValue = const TextEditingValue(text: '');
      final newValue = const TextEditingValue(text: '-5');
      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text.startsWith('-'), isFalse);
    });
  });

  test('should return an empty string if no value is provided', () {
    expect(formatter.getFormattedValue(), '');

    final formatted = formatter.formatString('12345');

    expect(formatter.getFormattedValue(), formatted);

    expect(formatted, contains('.'));
  });

  test('should format string correctly', () {
    final formatted = formatter.formatString('1000');
    expect(formatted, contains('10.00'));

    final formattedNegative = formatter.formatString('-2500');
    expect(formattedNegative, contains('-'));
    expect(formattedNegative, contains('-25.00'));
  });

  test('should return the correct number format', () {
    final nf = formatter.numberFormat;

    expect(nf, isA<NumberFormat>());
    expect(nf.locale, 'en_US');
    expect(nf.currencySymbol, '\$');
    expect(nf.decimalDigits, 2);
  });

  test('CurrencyFormatter sets symbol at right side', () {
    final formatter = CurrencyFormatter.simpleCurrency(
      locale: 'en_US',
      name: 'USD',
      decimalDigits: 2,
      showSymbol: true,
      symbolOnLeft: false,
    );

    final oldValue = TextEditingValue(text: '');
    final newValue = TextEditingValue(text: '12345');

    final result = formatter.formatEditUpdate(oldValue, newValue);

    expect(result.text.endsWith('\$'), true);
    expect(result.text.contains('123.45'), true);
  });

  test('CurrencyFormatter negative with symbol at right side', () {
    final formatter = CurrencyFormatter.simpleCurrency(
      locale: 'en_US',
      name: 'USD',
      decimalDigits: 2,
      showSymbol: true,
      symbolOnLeft: false,
      enableNegative: true,
    );

    final oldValue = TextEditingValue(text: '');
    final newValue = TextEditingValue(text: '-12345');

    final result = formatter.formatEditUpdate(oldValue, newValue);

    expect(result.text.startsWith('-'), true);
    expect(result.text.endsWith('\$'), true);
    expect(result.text.contains('123.45'), true);
  });
}
