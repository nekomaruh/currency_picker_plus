import 'package:currency_picker_plus/src/widgets/flags/svg_picture_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:currency_picker_plus/currency_picker_plus.dart';

class CurrencyAssetFlag extends StatelessWidget {
  final Currency currency;
  final BoxFit fit;
  final double width;
  final double? height;
  final Widget? placeholder;
  final SvgPictureBuilder? svgPictureBuilder;

  const CurrencyAssetFlag({
    super.key,
    required this.currency,
    this.fit = BoxFit.cover,
    this.width = 40,
    this.height,
    this.placeholder,
    this.svgPictureBuilder,
  });

  Widget _defaultBuilder({
    required String assetName,
    required String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    WidgetBuilder? placeholderBuilder,
  }) {
    return SvgPicture.asset(
      assetName,
      package: package,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: placeholderBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final builder = svgPictureBuilder ?? _defaultBuilder;
    final placeholderBuilder = placeholder != null ? (_) => placeholder! : null;

    return builder(
      assetName: currency.flagAsset,
      package: currency.flagAssetSvgPackage,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: placeholderBuilder,
    );
  }
}
