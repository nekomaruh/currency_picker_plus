import 'package:currency_picker_plus/src/theme/currency_picker_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyPickerThemeData', () {
    test('should initialize with default values', () {
      const shape = RoundedRectangleBorder();
      const backgroundColor = Colors.blue;
      const titleTextStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
      const subtitleTextStyle = TextStyle(fontSize: 16, color: Colors.grey);
      const currencySignTextStyle = TextStyle(fontSize: 22);
      const inputDecoration = InputDecoration(hintText: 'Search...');
      const flagSize = 30.0;
      const bottomSheetHeight = 400.0;

      final themeData = CurrencyPickerThemeData(
        shape: shape,
        backgroundColor: backgroundColor,
        titleTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        currencySignTextStyle: currencySignTextStyle,
        inputDecoration: inputDecoration,
        flagSize: flagSize,
        bottomSheetHeight: bottomSheetHeight,
      );

      expect(themeData.shape, shape);
      expect(themeData.backgroundColor, backgroundColor);
      expect(themeData.titleTextStyle, titleTextStyle);
      expect(themeData.subtitleTextStyle, subtitleTextStyle);
      expect(themeData.currencySignTextStyle, currencySignTextStyle);
      expect(themeData.inputDecoration, inputDecoration);
      expect(themeData.flagSize, flagSize);
      expect(themeData.bottomSheetHeight, bottomSheetHeight);
    });

    test('should allow initialization with null values', () {
      final themeData = CurrencyPickerThemeData();

      expect(themeData.shape, isNull);
      expect(themeData.backgroundColor, isNull);
      expect(themeData.titleTextStyle, isNull);
      expect(themeData.subtitleTextStyle, isNull);
      expect(themeData.currencySignTextStyle, isNull);
      expect(themeData.inputDecoration, isNull);
      expect(themeData.flagSize, isNull);
      expect(themeData.bottomSheetHeight, isNull);
    });
  });
}
