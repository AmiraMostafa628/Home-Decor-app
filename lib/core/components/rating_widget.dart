import 'package:decor/core/resources/color_manager.dart';
import 'package:flutter/material.dart';


class StarRating extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double iconSize;

  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 0; i < maxRating; i++) {
      if (i < rating.floor()) {

        stars.add(Icon(Icons.star, color: ColorManager.primaryColor, size: iconSize));
      } else if (i < rating && rating - i >= 0.5) {

        stars.add(Icon(Icons.star_half, color: ColorManager.primaryColor, size: iconSize));
      } else {
        stars.add(Icon(Icons.star_border, color: ColorManager.primaryColor, size: iconSize));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
