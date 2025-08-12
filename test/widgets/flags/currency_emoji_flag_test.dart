import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_picker_plus/currency_picker_plus.dart';

import '../../mock/currency_model_mock.dart';

void main() {
  testWidgets('CurrencyEmojiFlag displays correct emoji and size', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CurrencyEmojiFlag(currency: usdMock, size: 50)),
      ),
    );

    final textWidget = tester.widget<Text>(find.text('🇺🇸'));
    expect(textWidget.data, '🇺🇸');
    expect(textWidget.style?.fontSize, 50);
  });
}
