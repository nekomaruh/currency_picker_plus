import 'package:currency_picker_plus/src/extension/currency_raw_formatter_ext.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_picker_plus/src/data/currency.dart';

void main() {
  group('CurrencyRawFormatter.format', () {
    final usd = Currency(
      code: "USD",
      name: "United States Dollar",
      symbol: "\$",
      flag: "US",
      decimalDigits: 2,
      number: 840,
      namePlural: "US dollars",
      thousandsSeparator: ",",
      decimalSeparator: ".",
      spaceBetweenAmountAndSymbol: false,
      symbolOnLeft: true,
      locale: "en-US",
    );

    final krw = Currency(
      code: "KRW",
      name: "South Korea Won",
      symbol: "₩",
      flag: "KR",
      decimalDigits: 0,
      number: 410,
      namePlural: "South Korean won",
      thousandsSeparator: ",",
      decimalSeparator: ".",
      spaceBetweenAmountAndSymbol: false,
      symbolOnLeft: true,
      locale: "ko-KR",
    );

    test('formats positive number without symbol', () {
      expect(usd.format(rawValue: '1234567.89'), '1,234,567.89');
    });

    test('formats positive number with symbol', () {
      expect(
        usd.format(rawValue: '1234567.89', showSymbol: true),
        '\$1,234,567.89',
      );
    });

    test('formats negative number without symbol', () {
      expect(usd.format(rawValue: '-1234567.89'), '-1,234,567.89');
    });

    test('formats negative number with symbol', () {
      expect(
        usd.format(rawValue: '-1234567.89', showSymbol: true),
        '\$-1,234,567.89',
      );
    });

    test('formats number with forceSymbolSpace', () {
      expect(
        usd.format(
          rawValue: '1234.5',
          showSymbol: true,
          forceSymbolSpace: true,
        ),
        '\$ 1,234.50',
      );
    });

    test('formats number with maxDecimals', () {
      expect(usd.format(rawValue: '1234.5678', maxDecimals: 1), '1,234.5');
    });

    test('formats zero with symbol', () {
      expect(usd.format(rawValue: '', showSymbol: true), '\$0');
    });

    test('formats currency with zero decimals', () {
      expect(krw.format(rawValue: '1234567'), '1,234,567');
      expect(
        krw.format(rawValue: '1234567', showSymbol: true),
        '₩1,234,567',
      ); // spaceBetweenAmountAndSymbol true
    });

    test('formats small number with zero decimals', () {
      expect(krw.format(rawValue: '34.78', showSymbol: true), '₩34');
    });
  });
}
