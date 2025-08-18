import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyMapper', () {
    final jsonExample = {
      'code': 'USD',
      'name': 'United States Dollar',
      'symbol': '\$',
      'flag': 'US',
      'number': 840,
      'decimal_digits': 2,
      'name_plural': 'US dollars',
      'decimal_separator': '.',
      'thousands_separator': ',',
      'symbol_on_left': true,
      'space_between_amount_and_symbol': false,
      'locale': 'en_US',
    };

    final currencyExample = CurrencyMapper.fromJson(jsonExample);

    test('fromJson converts JSON to Currency correctly', () {
      expect(currencyExample.code, 'USD');
      expect(currencyExample.name, 'United States Dollar');
      expect(currencyExample.symbol, '\$');
      expect(currencyExample.flag, 'US');
      expect(currencyExample.number, 840);
      expect(currencyExample.decimalDigits, 2);
      expect(currencyExample.namePlural, 'US dollars');
      expect(currencyExample.decimalSeparator, '.');
      expect(currencyExample.thousandsSeparator, ',');
      expect(currencyExample.symbolOnLeft, true);
      expect(currencyExample.spaceBetweenAmountAndSymbol, false);
      expect(currencyExample.locale, 'en_US');
    });

    test('toJson converts Currency to JSON correctly', () {
      final json = CurrencyMapper.toJson(currencyExample);
      expect(json, jsonExample);
    });

    test('toJson(fromJson(json)) is symmetric', () {
      final jsonRoundTrip = CurrencyMapper.toJson(
        CurrencyMapper.fromJson(jsonExample),
      );
      expect(jsonRoundTrip, jsonExample);
    });
  });
}
