import 'package:currency_picker_plus/src/widgets/flags/svg_picture_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../currency_picker_plus.dart';

class CurrencyAssetFlagCircular extends StatelessWidget {
  final Currency currency;
  final BoxFit fit;
  final double size;
  final Widget? placeholder;
  final SvgPictureBuilder? svgPictureBuilder;

  const CurrencyAssetFlagCircular({
    super.key,
    required this.currency,
    this.fit = BoxFit.cover,
    this.size = 40,
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

    return SizedBox(
      width: size,
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: builder(
            assetName: currency.flagAsset,
            package: currency.flagAssetSvgPackage,
            width: size,
            height: size,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
          ),
        ),
      ),
    );
  }
}
