import 'package:flutter/material.dart';

enum IconPosition {
  leading,
  middle,
  trailing,
}

class CountryFlagDecoration {
  /// Default value is `32`
  final double width;
  final double? height;

  /// Border radius around country flag image.
  ///
  /// Default value is `BorderRadius.zero`.
  final BorderRadiusGeometry borderRadius;

  /// Default value is `Clip.antiAlias`
  final Clip clipBehavior;

  final CustomClipper<RRect>? clipper;

  const CountryFlagDecoration({
    this.width = 32,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.clipBehavior = Clip.antiAlias,
    this.clipper,
  });
}

bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;
