import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyService', () {
    final service = CurrencyService.instance;

    test('getAll returns all currencies', () {
      final all = service.getAll();
      expect(all.length, 161);
      expect(all, contains(service.findByCode('USD')));
      expect(all, contains(service.findByCode('EUR')));
      expect(all, contains(service.findByCode('JPY')));
    });

    test('findByCode finds currency by code no matter case', () {
      expect(service.findByCode('usd'), service.findByCode('USD'));
      expect(service.findByCode('USD'), service.findByCode('USD'));
      expect(service.findByCode('jPy'), service.findByCode('JPY'));
      expect(service.findByCode('ABC'), isNull);
    });

    test('findCurrenciesByCode returns only matching currencies', () {
      final result = service.findCurrenciesByCode(['USD', 'abc', 'JPY']);
      expect(result.length, 2);
      expect(result, contains(service.findByCode('USD')));
      expect(result, contains(service.findByCode('JPY')));
      expect(result.any((c) => c.code == 'ABC'), isFalse);
    });
  });
}
