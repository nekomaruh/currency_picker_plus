import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyPlaceholder', () {
    test('returns numeric only when showSymbol is false', () {
      final currency = Currency(
        symbol: '\$',
        symbolOnLeft: true,
        spaceBetweenAmountAndSymbol: false,
        decimalSeparator: '.',
        decimalDigits: 2,
        code: '',
        name: '',
        flag: '',
        number: 0,
        namePlural: '',
        thousandsSeparator: '',
        locale: '',
      );
      expect(currency.emptyPlaceholder(), '0.00');
    });

    test('places symbol on left without space', () {
      final currency = Currency(
        symbol: '\$',
        symbolOnLeft: true,
        spaceBetweenAmountAndSymbol: false,
        decimalSeparator: '.',
        decimalDigits: 2,
        code: '',
        name: '',
        flag: '',
        number: 0,
        namePlural: '',
        thousandsSeparator: '',
        locale: '',
      );
      expect(currency.emptyPlaceholder(showSymbol: true), '\$0.00');
    });

    test(
      'places symbol on left with space if spaceBetweenAmountAndSymbol is true',
      () {
        final currency = Currency(
          symbol: '\$',
          symbolOnLeft: true,
          spaceBetweenAmountAndSymbol: true,
          decimalSeparator: '.',
          decimalDigits: 2,
          code: '',
          name: '',
          flag: '',
          number: 0,
          namePlural: '',
          thousandsSeparator: '',
          locale: '',
        );
        expect(currency.emptyPlaceholder(showSymbol: true), '\$ 0.00');
      },
    );

    test('places symbol on right without space', () {
      final currency = Currency(
        symbol: '\$',
        symbolOnLeft: false,
        spaceBetweenAmountAndSymbol: false,
        decimalSeparator: ',',
        decimalDigits: 2,
        code: '',
        name: '',
        flag: '',
        number: 0,
        namePlural: '',
        thousandsSeparator: '',
        locale: '',
      );
      expect(currency.emptyPlaceholder(showSymbol: true), '0,00\$');
    });

    test('places symbol on right with space when forceSymbolSpace is true', () {
      final currency = Currency(
        symbol: '\$',
        symbolOnLeft: false,
        spaceBetweenAmountAndSymbol: false,
        decimalSeparator: ',',
        decimalDigits: 2,
        code: '',
        name: '',
        flag: '',
        number: 0,
        namePlural: '',
        thousandsSeparator: '',
        locale: '',
      );
      expect(
        currency.emptyPlaceholder(showSymbol: true, forceSymbolSpace: true),
        '0,00 \$',
      );
    });

    test('works with zero decimal digits', () {
      final currency = Currency(
        symbol: '\$',
        symbolOnLeft: true,
        spaceBetweenAmountAndSymbol: false,
        decimalSeparator: ',',
        decimalDigits: 0,
        code: '',
        name: '',
        flag: '',
        number: 0,
        namePlural: '',
        thousandsSeparator: '',
        locale: '',
      );
      expect(currency.emptyPlaceholder(showSymbol: true), '\$0');
    });
  });
}
