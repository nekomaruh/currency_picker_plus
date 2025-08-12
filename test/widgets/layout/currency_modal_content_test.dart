import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_picker_plus/currency_picker_plus.dart';

import '../../mock/mock_currency_service.dart';

void main() {
  testWidgets('CurrencyModalContent displays all currencies', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurrencyModalContent(
            currencyService: mockService,
            onSelect: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('United States Dollar'), findsOneWidget);
    expect(find.text('Euro'), findsOneWidget);
  });

  testWidgets('CurrencyModalContent filters currencies via search', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurrencyModalContent(
            currencyService: mockService,
            currencyFilter: ['EUR'],
            onSelect: (_) {},
          ),
        ),
      ),
    );

    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'Euro');
    await tester.pumpAndSettle();

    expect(find.text('Euro').first, findsOneWidget);
    expect(find.text('United States Dollar'), findsNothing);
  });

  testWidgets(
    'CurrencyModalContent shows favorites and a divider when favorites provided',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CurrencyModalContent(
              currencyService: mockService,
              onSelect: (_) {},
              favorite: ['EUR'],
            ),
          ),
        ),
      );

      expect(find.text('Euro'), findsWidgets);
      expect(find.byType(Divider), findsOneWidget);
    },
  );

  testWidgets('should filter currencies by code and not find currency', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurrencyModalContent(
            currencyService: mockService,
            onSelect: (_) {},
          ),
        ),
      ),
    );

    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'usd');
    await tester.pumpAndSettle();

    expect(find.text('United States Dollar'), findsOneWidget);

    expect(find.text('Euro'), findsNothing);
  });

  testWidgets(
    'CurrencyModalContent shows all currencies when search is empty',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CurrencyModalContent(
              currencyService: mockService,
              onSelect: (_) {},
            ),
          ),
        ),
      );

      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      await tester.enterText(searchField, 'euro');
      await tester.pumpAndSettle();

      await tester.enterText(searchField, '');
      await tester.pumpAndSettle();

      expect(find.text('United States Dollar'), findsOneWidget);
      expect(find.text('Euro'), findsOneWidget);
    },
  );
}
