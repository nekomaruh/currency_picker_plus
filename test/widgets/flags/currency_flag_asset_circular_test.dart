import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/currency_model_mock.dart';

void main() {
  testWidgets('CurrencyAssetFlagCircular shows SVG with correct dimensions', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurrencyAssetFlagCircular(
            currency: usdMock,
            size: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    final svgFinder = find.byType(SvgPicture);
    expect(svgFinder, findsOneWidget);

    final SvgPicture svgWidget = tester.widget(svgFinder);
    expect(svgWidget.width, 50);
    expect(svgWidget.height, 50);
    expect(svgWidget.fit, BoxFit.contain);

    expect(svgWidget.placeholderBuilder, isNull);
  });

  testWidgets('shows placeholder when provided', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurrencyAssetFlagCircular(
            currency: usdMock,
            placeholder: const Icon(Icons.flag, size: 40),
            svgPictureBuilder:
                ({
                  required String assetName,
                  required String? package,
                  double? width,
                  double? height,
                  BoxFit fit = BoxFit.cover,
                  WidgetBuilder? placeholderBuilder,
                }) {
                  if (placeholderBuilder != null) {
                    return Builder(
                      builder: (context) => placeholderBuilder(context),
                    );
                  }
                  return const SizedBox.shrink();
                },
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.flag), findsOneWidget);
  });
}
