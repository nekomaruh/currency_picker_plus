import 'currency.dart';

class CurrencyMapper {
  static Currency fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      name: json['name'],
      symbol: json['symbol'],
      flag: json['flag'],
      number: json['number'],
      decimalDigits: json['decimal_digits'],
      namePlural: json['name_plural'],
      decimalSeparator: json['decimal_separator'],
      thousandsSeparator: json['thousands_separator'],
      symbolOnLeft: json['symbol_on_left'],
      spaceBetweenAmountAndSymbol: json['space_between_amount_and_symbol'],
      locale: json['locale']
    );
  }

  static Map<String, dynamic> toJson(Currency currency) {
    return {
      'code': currency.code,
      'name': currency.name,
      'symbol': currency.symbol,
      'flag': currency.flag,
      'number': currency.number,
      'decimal_digits': currency.decimalDigits,
      'name_plural': currency.namePlural,
      'decimal_separator': currency.decimalSeparator,
      'thousands_separator': currency.thousandsSeparator,
      'symbol_on_left': currency.symbolOnLeft,
      'space_between_amount_and_symbol': currency.spaceBetweenAmountAndSymbol,
      'locale': currency.locale
    };
  }
}
