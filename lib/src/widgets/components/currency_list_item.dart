import 'package:flutter/material.dart';

import '../../../currency_picker_plus.dart';

class CurrencyListItem extends StatelessWidget {
  final Currency currency;
  final Function(Currency currency) onSelect;
  final bool showFlag;
  final bool showCode;
  final bool showName;
  final CurrencyPickerThemeData? theme;

  const CurrencyListItem({
    super.key,
    required this.currency,
    required this.onSelect,
    required this.showFlag,
    required this.showCode,
    required this.showName,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle titleTextStyle =
        theme?.titleTextStyle ?? TextStyle(fontSize: 17);
    final TextStyle subtitleTextStyle =
        theme?.subtitleTextStyle ??
        TextStyle(fontSize: 15, color: Theme.of(context).hintColor);
    final currencySignTextStyle =
        theme?.currencySignTextStyle ?? TextStyle(fontSize: 18);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onSelect(currency);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    if (showFlag) ...[
                      CurrencyAssetFlag(currency: currency, width: 40),
                      const SizedBox(width: 20),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: showCode,
                            child: Text(currency.code, style: titleTextStyle),
                          ),
                          Visibility(
                            visible: showName,
                            child: Text(
                              currency.name,
                              style: showCode
                                  ? subtitleTextStyle
                                  : titleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(currency.symbol, style: currencySignTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
