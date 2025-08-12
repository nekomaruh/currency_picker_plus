import 'currencies.dart';
import 'currency.dart';

class CurrencyService {
  CurrencyService._()
      : _currencies = currencies,
        _byCode = {
          for (var currency in currencies)
            currency.code.toUpperCase(): currency,
        };

  static final CurrencyService instance = CurrencyService._();

  final List<Currency> _currencies;
  final Map<String, Currency> _byCode;

  List<Currency> getAll() => _currencies;

  Currency? findByCode(String code) => _byCode[code.toUpperCase()];

  List<Currency> findCurrenciesByCode(List<String> codes) {
    return codes.map(findByCode).nonNulls.toList();
  }
}
