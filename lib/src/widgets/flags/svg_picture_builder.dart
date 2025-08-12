import 'package:flutter/material.dart';

typedef SvgPictureBuilder =
    Widget Function({
      required String assetName,
      required String? package,
      double? width,
      double? height,
      BoxFit fit,
      WidgetBuilder? placeholderBuilder,
    });
