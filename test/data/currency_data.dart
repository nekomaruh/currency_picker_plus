import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('currenciesOld', () {
    test('all items are Currency instances', () {
      for (final currency in currencies) {
        expect(
          currency,
          isA<Currency>(),
          reason: 'All items should be Currency instances',
        );
      }
    });
  });
}
