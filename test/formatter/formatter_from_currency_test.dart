import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/currency_model_mock.dart';

void main() {
  group('formatterFromCurrency', () {
    test('maps to CurrencyFormatter', () {
      final CurrencyFormatter formatter = formatterFromCurrency(
        currency: clpMock,
        showSymbol: true,
      );
      expect(formatter, isNotNull);
    });

    test('uses showSymbol false by default', () {
      final formatter = formatterFromCurrency(currency: clpMock);
      expect(formatter.showSymbol, false);
    });
  });
}
