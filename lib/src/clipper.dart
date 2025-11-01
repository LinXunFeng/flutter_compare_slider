/*
 * @Author: LinXunFeng linxunfeng@yeah.net
 * @Repo: https://github.com/LinXunFeng/flutter_compare_slider
 * @Date: 2025-11-01 14:30:01
 */

import 'package:flutter/material.dart';

/// The direction of the compare slider.
enum CompareSliderDirection {
  horizontal,
  vertical,
}

/// A custom clipper for the [CompareSlider] component.
class CompareSliderRectClipper extends CustomClipper<Rect> {
  const CompareSliderRectClipper({
    required this.direction,
    required this.clipFactor,
  });

  /// The direction of the clip.
  final CompareSliderDirection direction;

  /// The factor by which the component's size is clipped.
  final double clipFactor;

  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(
      0.0,
      0.0,
      direction == CompareSliderDirection.horizontal
          ? size.width * clipFactor
          : size.width,
      direction == CompareSliderDirection.vertical
          ? size.height * clipFactor
          : size.height,
    );

    return rect;
  }

  @override
  bool shouldReclip(CompareSliderRectClipper oldClipper) =>
      oldClipper.clipFactor != clipFactor || oldClipper.direction != direction;
}
