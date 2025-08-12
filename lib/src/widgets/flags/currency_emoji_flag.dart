import 'package:flutter/material.dart';

import '../../../currency_picker_plus.dart';

class CurrencyEmojiFlag extends StatelessWidget {
  final Currency currency;
  final double size;

  const CurrencyEmojiFlag({
    super.key,
    required this.currency,
    this.size = 40
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      currency.flagEmoji,
      style: TextStyle(fontSize: size),
    );
  }
}
