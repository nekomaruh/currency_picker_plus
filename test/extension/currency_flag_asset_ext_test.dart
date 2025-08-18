import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/currency_model_mock.dart';

void main() {
  group('CurrencyFlagAsset', () {
    test('flagAsset returns the correct path', () {
      expect(usdMock.flagAsset, 'assets/flags_svg/usd.svg');
      expect(brlMock.flagAsset, 'assets/flags_svg/brl.svg');
    });

    test('flagAssetSvgPackage returns the correct package', () {
      expect(usdMock.flagAssetSvgPackage, 'currency_picker_plus');
    });
  });
}
