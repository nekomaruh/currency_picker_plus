import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('showCurrencyBottomSheet shows modal with content', (
    WidgetTester tester,
  ) async {
    final testKey = GlobalKey();

    // Base widget to perform the test
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              key: testKey,
              onPressed: () {
                showCurrencyBottomSheet(
                  context: context,
                  theme: CurrencyPickerThemeData(),
                  onSelect: (currency) {},
                );
              },
              child: Text('Open BottomSheet'),
            ),
          ),
        ),
      ),
    );

    // Verify that the button is present
    expect(find.text('Open BottomSheet'), findsOneWidget);

    // Tap the button to open the bottom sheet
    await tester.tap(find.byKey(testKey));
    // Wait for the modal animation to complete
    await tester.pumpAndSettle();

    // Verify that CurrencyModalContent is present
    expect(find.byType(CurrencyModalContent), findsOneWidget);
  });
}
