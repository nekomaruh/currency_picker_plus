import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/currency_model_mock.dart';

void main() {
  testWidgets('CurrencyListItem calls onSelect y close navigator onTap', (
    tester,
  ) async {
    Currency? selectedCurrency;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return CurrencyListItem(
                currency: usdMock,
                onSelect: (currency) {
                  selectedCurrency = currency;
                },
                showFlag: false,
                showCode: true,
                showName: true,
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('USD'), findsOneWidget);
    expect(find.text('United States Dollar'), findsOneWidget);

    await tester.tap(find.byType(CurrencyListItem));
    await tester.pumpAndSettle();

    expect(selectedCurrency, isNotNull);
    expect(selectedCurrency!.code, 'USD');
  });

  testWidgets('CurrencyListItem onTap cierra la ruta (Navigator.pop)', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  child: Text('Open Modal'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return CurrencyListItem(
                          currency: usdMock,
                          onSelect: (_) {},
                          showFlag: false,
                          showCode: true,
                          showName: true,
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Modal'));
    await tester.pumpAndSettle();

    expect(find.text('USD'), findsOneWidget);

    await tester.tap(find.byType(CurrencyListItem));
    await tester.pumpAndSettle();

    expect(find.text('USD'), findsNothing);
  });
}
