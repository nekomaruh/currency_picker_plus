import 'package:currency_picker_plus/currency_picker_plus.dart';

import 'currency_model_mock.dart';

class MockCurrencyService implements CurrencyService {
  final List<Currency> _currencies;

  MockCurrencyService(this._currencies);

  @override
  List<Currency> getAll() => _currencies;

  @override
  Currency? findByCode(String code) =>
      _currencies.firstWhere((c) => c.code.toUpperCase() == code.toUpperCase());

  @override
  List<Currency> findCurrenciesByCode(List<String> codes) {
    final up = codes.map((e) => e.toUpperCase()).toSet();
    return _currencies.where((c) => up.contains(c.code.toUpperCase())).toList();
  }
}

final mockService = MockCurrencyService([usdMock, eurMock]);