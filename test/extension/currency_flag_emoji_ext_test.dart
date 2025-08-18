import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/currency_model_mock.dart';

void main() {
  group('CurrencyFlagEmoji', () {
    test('flagEmoji returns the correct emoji for US', () {
      expect(usdMock.flagEmoji, '🇺🇸');
    });

    test('flagEmoji returns the correct emoji for BR', () {
      expect(brlMock.flagEmoji, '🇧🇷');
    });

    test('flagEmoji returns the correct emoji for JP', () {
      expect(jpyMock.flagEmoji, '🇯🇵');
    });
  });
}
