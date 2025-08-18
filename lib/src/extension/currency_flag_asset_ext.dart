import '../data/currency.dart';

extension CurrencyFlagAsset on Currency {
  String get flagAsset {
    return 'assets/flags_svg/${code.toLowerCase()}.svg';
  }

  String get flagAssetSvgPackage => 'currency_picker_plus';
}
