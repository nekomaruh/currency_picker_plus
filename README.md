# currency_picker_plus

Enhanced and customizable Flutter currency picker widget with extra features.

<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->


![Coverage](https://raw.githubusercontent.com/nekomaruh/currency_picker_plus/main/coverage_badge.svg)
[![pub package](https://img.shields.io/pub/v/currency_picker_plus.svg)](https://pub.dev/packages/currency_picker_plus)


| ![Example 1](https://raw.githubusercontent.com/nekomaruh/currency_picker_plus/main/example1.webp) | ![Example 2](https://raw.githubusercontent.com/nekomaruh/currency_picker_plus/main/example2.webp) |
|:-------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------:|


## Features

Based on [currency_picker](https://pub.dev/packages/currency_picker) and 
[currency_text_input_formatter](https://pub.dev/packages/currency_picker) packages.

- 🚀 Supports 161+ global currencies (1.2MB) with crisp, scalable SVG flags.
- 🌍 Built-in base locales for all default currencies
- 🔌 Seamless data loading service designed for easy dependency injection and clean architecture
- ✨ Extensions for loading images, empty placeholders, and emojis
- 💸 Customizable currency formatter for text input fields
- 💲 Supports huge number transformations
- 📱 Customizable modal components, autofocus keyboard search, and fixed drag behavior
- 🎨 Three stunning flag widgets included: SVG, SVG Circular, Emoji Symbol

## Getting started

Add the package to your pubspec.yaml:

 ```yaml
 currency_picker_plus: ^1.0.0
 ```

## Usage

### Loading the Service

```dart
final service = CurrencyService.instance;
```
- `service.getAll()`  
  Returns a list of currencies
  
- `service.findByCode("USD")`
  Returns the currency instance with USD data

- `service.findCurrenciesByCode("USD","EUR","JPY")`
  Returns the list of selected currencies
  
  
### Launch Modal

Default Modal: 

```dart
// State holder
Currency? data;

// Launch on button tap
showCurrencyBottomSheet(
  context: context,
  onSelect: (currency) {
    data = currency; // 👈 update state
  },
);
```
Custom Modal:

```dart
final service = CurrencyService.instance;

showCurrencyBottomSheet(
  context: context,
  currencyService: service, // 👈 inject service here!
  onSelect: (currency) {}, // 👈 update state
  showFlag: true,
  searchHint: 'Hello',
  showCurrencyName: true,
  showCurrencyCode: true,
  showSearchField: true,
  currencyFilter: ["USD","EUR"],
  showSearchDivider: false,
  showDragHandle: false,
  autofocusKeyboard: true,
  favorite: ["USD"],
  theme: CurrencyPickerThemeData(
    flagSize: 25,
    titleTextStyle: TextStyle(fontSize: 17),
    subtitleTextStyle: TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
    bottomSheetHeight: MediaQuery.of(context).size.height / 2,
    // Optional. Styles the search field.
    inputDecoration: InputDecoration(
      labelText: 'Search',
      hintText: 'Start typing to search',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFF8C98A8).withOpacity(0.2),
        ),
      ),
    ),
  ),
);
```

Parameters:

- `currencyService`: Service singleton instance. 
- `onSelect`: Called when a currency is select. The currency picker passes the new value to the callback (required)
- `showFlag`: Shows flag for each currency. Default value true (optional).
- `searchHint`: Option to customize hint of the search TextField (optional).
- `showCurrencyName`: Option to show/hide the currency name, default value true (optional).
- `showCurrencyCode`: Option to show/hide the currency code, default value true (optional).
- `showSearchField`: Option to show/hide the search TextField, default value true (optional).
- `currencyFilter`: Can be used to filter the Currency list (optional).
- `showSearchDivider`: Option to show/hide divider below search bar (optional).
- `showDragHandle`: Option to show/hide modal drag handle (optional).
- `autofocusKeyboard`: Option to show/hide keyboard with autofocus on search bar, when modal is opened (optional).
- `favorite`: Can be used to show the favorite currencies at the top of the list (optional).
theme: Can be used to customizing the currency list bottom sheet. (optional).
- `theme`: Can be used to customizing the currency list bottom sheet. (optional).

### Service Dependency Injection

Using [get_it](https://pub.dev/packages/get_it):


```dart
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<CurrencyService>(CurrencyService.instance);
}

void main() {
  final service = getIt<CurrencyService>();
  final allCurrencies = service.getAll();
}

```

Using [riverpod](https://pub.dev/packages/riverpod):

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currencyServiceProvider = Provider<CurrencyService>((ref) {
  return CurrencyService.instance;
});

```

Using [provider](https://pub.dev/packages/provider):


```dart
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<CurrencyService>.value(
          value: CurrencyService.instance,
        ),
      ],
      child: const MyApp(),
    ),
  );
}
```




### Creating a Currency Instance

```dart
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
```

### Extensions

- `currency.flagAsset`  
  Returns the SVG image path of the flag.

- `currency.flagAssetSvgPackage`  
  Returns the package name required to load the SVG image.

- `currency.flagEmoji`  
  Returns the emoji flag symbol (e.g., "US" → 🇺🇸).

- `currency.emptyPlaceholder(showSymbol, forceSymbolSpace)`  
  Returns a placeholder widget for input fields.

### Mappers

Although it is not used internally in the package, exposing a way to store and retrieve data can be useful.

- `CurrencyMapper.fromJson(Map<String, dynamic>)`  
  Creates a `Currency` object from JSON data.

- `CurrencyMapper.toJson(Currency)`  
  Converts a `Currency` object back to JSON.
  


### CurrencyAssetFlag

| Property        | Details                                              |
|-----------------|------------------------------------------------------|
| **Description** | Rectangular flag with customizable width and height.|
| **Key Params**  | `currency`, `fit`, `width`, `height`, `placeholder`, `svgPictureBuilder` |
| **Example**     | ```CurrencyAssetFlag(currency: eur, fit: BoxFit.cover, width: 48, height: 32)``` |
| **Image**       | <img src="https://raw.githubusercontent.com/nekomaruh/currency_picker_plus/main/assets/flags_svg/eur.svg" width="48px" height="48px" />    |



### CurrencyAssetFlagCircular

| Property        | Details                                            |
|-----------------|----------------------------------------------------|
| **Description** | Circular flag with uniform size.                    |
| **Key Params**  | `currency`, `fit`, `size`, `placeholder`, `svgPictureBuilder` |
| **Example**     | ```CurrencyAssetFlagCircular(currency: eur, size: 48)``` |
| **Image**       | <img src="https://raw.githubusercontent.com/nekomaruh/currency_picker_plus/main/assets/flags_svg/eur.svg" style="width: 48px; height: 48px; object-fit: cover; border-radius: 50%;"  alt="Circular Flag"  />        |



### CurrencyEmojiFlag

| Property        | Details                              |
|-----------------|------------------------------------|
| **Description** | Flag shown as emoji symbol.         |
| **Key Params**  | `currency`, `size`                  |
| **Example**     | ```CurrencyEmojiFlag(currency: eur, size: 48)``` |
| **Image**       | <span style="font-size: 48px;">🇪🇺</span>  |
           


### Currency Formatter

Simply create a formatter using the helper function:

```dart
final Currency currency;
final formatter = formatterFromCurrency(currency);
```

Or see the example file for details on how to use it:

```dart
final formatter = CurrencyFormatter.currency(
  locale: 'en_US',
  decimalDigits: 2,
  turnOffGrouping: false,
  enableNegative: true,
  inputDirection: InputDirection.right,
  minValue: Decimal.zero,
  maxValue: Decimal.parse('100000000000000000'),
  onChange: (value) {
    print(value);
  },
  showSymbol: true,
  decimalSeparator: ',',
  thousandsSeparator: '.',
  symbolOnLeft: false,
  showSymbolSpace: true,
);
```

Parameters:

- `locale`: Sets the locale for formatting. 'en_US' means English (United States).
- `decimalDigits`: Number of digits shown after the decimal separator.
- `turnOffGrouping`: If true, disables thousand grouping.
- `enableNegative`: Allows entering negative numbers if true.
- `inputDirection`: Direction of input cursor; InputDirection.right means right to left.
- `minValue`: Minimum value allowed.
- `maxValue`: Maximum value allowed.
- `onChange`: Callback function triggered on value change.
- `showSymbol`: Shows currency symbol if true.
- `decimalSeparator`: Character used as the decimal separator.
- `thousandsSeparator`: Character used as the thousands separator.
- `symbolOnLeft`: If true, currency symbol on left; if false, on right.
- `showSymbolSpace`: Adds space between number and symbol if true.
  
  

## Additional information

- Enabled Currencies (161):
USD, EUR, JPY, GBP, AUD, CAD, CHF, CNY, HKD, NZD, SEK, KRW, SGD, NOK, MXN, INR, RUB, ZAR, TRY, BRL, TWD, DKK, PLN, THB, IDR, HUF, CZK, ILS, CLP, PHP, AED, COP, SAR, MYR, RON, AFN, ALL, DZD, AOA, ARS, AMD, AZN, BHD, BDT, BBD, BYN, BZD, BMD, BTN, BOB, BAM, BWP, BND, BGN, BIF, KHR, KYD, XAF, XOF, CDF, CRC, CUP, DOP, EGP, ETB, GMD, GEL, GHS, GTQ, GNF, GYD, HTG, ISK, IQD, JMD, JOD, KZT, KES, KWD, KGS, LAK, LBP, LRD, MKD, MGA, MWK, MVR, MUR, MDL, MNT, MAD, MZN, MMK, NAD, NPR, NIO, NGN, OMR, PKR, PGK, PYG, PEN, QAR, RWF, RSD, SCR, SOS, LKR, SRD, SYP, TZS, TOP, TTD, TND, UGX, UAH, UZS, UYU, VEF, VND, YER, ZMW, ZWL, IRR, LYD, TJS, TMT, AWG, BSD, CVE, XPF, KMF, HRK, DJF, XCD, ERN, FKP, FJD, GIP, GGP, HNL, IMP, JEP, LSL, MOP, MRU, ANG, PAB, SHP, WST, STN, SLE, SBD, SSP, XDR, SDG, SZL, VUV, VES, CLF, KPW.

- Disabled Currencies (13):
SPL, FOK, KID, TVD, BYR, CUC, LTL, LVL, SVC, MRO, STD, SLE, ZWG.
- **Note:** SSP may not be compatible with **currency API's**. Disabled currencies are excluded from the Service because they were replaced, redenominated, or became obsolete before 2025.
