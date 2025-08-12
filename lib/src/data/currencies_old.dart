import '../../currency_picker_plus.dart';

final List<Currency> currenciesOld = const [
  /// SPL (Saint Helena Pound): Former currency of Saint Helena.
  /// Status: No longer official.
  /// Replaced by: Saint Helena Pound (SHP), which is pegged to the British Pound Sterling (GBP).
  Currency(
    code: "SPL",
    name: "Saint Helena Pound",
    symbol: "£",
    flag: "SH",
    decimalDigits: 2,
    number: 994,
    namePlural: "Saint Helena pounds",
    thousandsSeparator: ",",
    decimalSeparator: ".",
    spaceBetweenAmountAndSymbol: true,
    symbolOnLeft: true,
    locale: "en-SH",
  ),

  /// FOK (Faroese króna): Regional currency used in the Faroe Islands.
  /// Status: No longer independent.
  /// Replaced by: Danish krone (DKK) as the official currency.
  Currency(
    code: "FOK",
    name: "Faroese Króna",
    symbol: "kr",
    flag: "FO",
    number: 234,
    decimalDigits: 2,
    namePlural: "Faroese krónur",
    decimalSeparator: ",",
    thousandsSeparator: ".",
    symbolOnLeft: false,
    spaceBetweenAmountAndSymbol: false,
    locale: "fo-FO",
  ),

  /// KID (Kiribati dollar): Proposed currency for Kiribati.
  /// Status: Never officially adopted or circulated.
  /// Replaced by: Australian dollar (AUD), as the official currency.
  Currency(
    code: "KID",
    name: "Kiribati Dollar",
    symbol: "\$",
    flag: "KI",
    number: 296,
    decimalDigits: 2,
    namePlural: "Kiribati dollars",
    decimalSeparator: ".",
    thousandsSeparator: ",",
    symbolOnLeft: true,
    spaceBetweenAmountAndSymbol: false,
    locale: "en-KI",
  ),

  /// TBD (Tuvaluan dollar): Proposed currency for Tuvalu, pegged to the Australian dollar (AUD).
  /// Status: Exists as a distinct currency but not widely circulated.
  /// Used alongside: Australian dollar (AUD), which is predominantly used in circulation.
  Currency(
    code: "TVD",
    name: "Tuvaluan Dollar",
    symbol: "\$",
    flag: "TV",
    number: 953,
    decimalDigits: 2,
    namePlural: "Tuvaluan dollars",
    decimalSeparator: ".",
    thousandsSeparator: ",",
    symbolOnLeft: true,
    spaceBetweenAmountAndSymbol: false,
    locale: "en-TV",
  ),

  /// BYR (Belarusian Ruble - old): Former currency of Belarus.
  /// Status: Replaced by BYN in 2016 after redenomination.
  /// Replaced by: Belarusian Ruble (BYN) as the current official currency.
  Currency(
    code: "BYR",
    name: "Belarusian Ruble",
    symbol: "Br",
    flag: "BY",
    number: 974,
    decimalDigits: 0,
    namePlural: "Belarusian rubles",
    decimalSeparator: ",",
    thousandsSeparator: "\u00A0",
    symbolOnLeft: true,
    spaceBetweenAmountAndSymbol: true,
    locale: "be-BY",
  ),

  /// CUC (Cuban Convertible Peso): Former currency of Cuba used alongside CUP.
  /// Status: Officially phased out as of January 2021.
  /// Replaced by: Cuban Peso (CUP) as the sole official currency.
  Currency(
    code: "CUC",
    name: "Cuban Convertible Peso",
    symbol: "\$",
    flag: "CU",
    number: 931,
    decimalDigits: 2,
    namePlural: "Cuban convertible pesos",
    decimalSeparator: ".",
    thousandsSeparator: ",",
    symbolOnLeft: true,
    spaceBetweenAmountAndSymbol: false,
    locale: "es-CU",
  ),

  /// LTL (Lithuanian Litas): Former currency of Lithuania.
  /// Status: Replaced by the Euro (EUR) in 2015.
  /// Replaced by: Euro (EUR) as the official currency.
  Currency(
    code: "LTL",
    name: "Lithuanian Litas",
    symbol: "Lt",
    flag: "LT",
    number: 440,
    decimalDigits: 2,
    namePlural: "Lithuanian litai",
    decimalSeparator: ",",
    thousandsSeparator: "\u00A0",
    symbolOnLeft: true,
    spaceBetweenAmountAndSymbol: true,
    locale: "lt-LT",
  ),

  /// LVL (Latvian Lats): Former currency of Latvia.
  /// Status: Replaced by the Euro (EUR) in 2014.
  /// Replaced by: Euro (EUR) as the official currency.
  Currency(
    code: "LVL",
    name: "Latvian Lats",
    symbol: "Ls",
    flag: "LV",
    number: 428,
    decimalDigits: 2,
    namePlural: "Latvian lati",
    decimalSeparator: ",",
    thousandsSeparator: "\u00A0",
    symbolOnLeft: true,
    spaceBetweenAmountAndSymbol: true,
    locale: "lv-LV",
  ),

  /// SVC (El Salvador Colon): Former currency of El Salvador.
  /// Status: No longer in use.
  /// Replaced by: United States Dollar (USD) as the official currency.
  Currency(
    code: "SVC",
    name: "El Salvador Colon",
    symbol: "₡",
    flag: "SV",
    number: 222,
    decimalDigits: 2,
    namePlural: "El Salvador colones",
    decimalSeparator: ".",
    thousandsSeparator: ",",
    symbolOnLeft: true,
    spaceBetweenAmountAndSymbol: false,
    locale: "es-SV",
  ),

  /// MRO (Mauritanian Ouguiya - old): Former currency of Mauritania.
  /// Status: Obsolete since 2018 due to redenomination.
  /// Replaced by: Mauritanian Ouguiya (MRU) with updated ISO code and value.
  Currency(
    code: "MRO",
    name: "Mauritanian Ouguiya",
    symbol: "UM",
    flag: "MR",
    number: 478,
    decimalDigits: 0,
    namePlural: "Mauritanian ouguiyas",
    decimalSeparator: ".",
    thousandsSeparator: ",",
    spaceBetweenAmountAndSymbol: true,
    symbolOnLeft: true,
    locale: "ar-MR",
  ),

  /// STD (São Tomé and Príncipe Dobra - old): Former currency of São Tomé and Príncipe.
  /// Status: Obsolete since 2018 due to redenomination.
  /// Replaced by: São Tomé and Príncipe Dobra (STN) with updated ISO code and value.
  Currency(
    code: "STD",
    name: "São Tomé and Príncipe Dobra",
    symbol: "Db",
    flag: "ST",
    number: 678,
    decimalDigits: 0,
    namePlural: "São Tomé and Príncipe dobras",
    decimalSeparator: ".",
    thousandsSeparator: ",",
    spaceBetweenAmountAndSymbol: true,
    symbolOnLeft: true,
    locale: "pt-ST",
  ),

  /// SLE (Sierra Leonean Leone): Current currency of Sierra Leone.
  /// Status: Introduced in 2022 to replace the old Sierra Leone Leone (SLL) at a rate of 1 SLE = 1,000 SLL.
  /// Replaced: Sierra Leone Leone (SLL) as the official currency.
  Currency(
    code: "SLE",
    name: "Sierra Leonean Leone",
    symbol: "Le",
    flag: "SL",
    decimalDigits: 2,
    number: 925,
    namePlural: "Sierra Leonean leones",
    thousandsSeparator: ",",
    decimalSeparator: ".",
    spaceBetweenAmountAndSymbol: false,
    symbolOnLeft: true,
    locale: "en-SL",
  ),

  /// ZWG (Zimbabwean Dollar): Former currency of Zimbabwe.
  /// Status: No longer in use.
  /// Replaced by: Newer Zimbabwean dollar versions (ZWL) and multiple foreign currencies.
  Currency(
    code: "ZWG",
    name: "Zimbabwean Dollar",
    symbol: "Z\$",
    flag: "ZW",
    decimalDigits: 2,
    number: 716,
    namePlural: "Zimbabwean dollars",
    thousandsSeparator: ",",
    decimalSeparator: ".",
    spaceBetweenAmountAndSymbol: true,
    symbolOnLeft: true,
    locale: "en-ZW",
  ),
];
