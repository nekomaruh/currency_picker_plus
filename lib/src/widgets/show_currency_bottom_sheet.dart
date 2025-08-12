import '../../currency_picker_plus.dart';
import 'package:flutter/material.dart';

void showCurrencyBottomSheet({
  required BuildContext context,
  required ValueChanged<Currency> onSelect,
  CurrencyService? currencyService,
  List<String>? favorite,
  List<String>? currencyFilter,
  String? searchHint,
  bool showSearchField = true,
  bool showFlag = true,
  bool showCurrencyName = true,
  bool showCurrencyCode = true,
  bool useRootNavigator = false,
  bool showSearchDivider = true,
  bool showDragHandle = false,
  bool autofocusKeyboard = false,
  ScrollPhysics? physics,
  CurrencyPickerThemeData? theme,
}) {
  final service = currencyService ?? CurrencyService.instance;
  final ShapeBorder shape =
      theme?.shape ??
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      );

  showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: useRootNavigator,
    shape: shape,
    backgroundColor: theme?.backgroundColor,
    showDragHandle: showDragHandle,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: autofocusKeyboard ? 0.95 : 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return CurrencyModalContent(
          currencyService: service,
          onSelect: onSelect,
          searchHint: searchHint,
          showSearchField: showSearchField,
          showFlag: showFlag,
          showDragHandle: showDragHandle,
          showCurrencyName: showCurrencyName,
          showCurrencyCode: showCurrencyCode,
          showSearchDivider: showSearchDivider,
          favorite: favorite,
          currencyFilter: currencyFilter,
          physics: physics,
          controller: scrollController,
          theme: theme,
          showKeyboard: autofocusKeyboard,
        );
      },
    ),
  );
}
