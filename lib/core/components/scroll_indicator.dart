import 'package:decor/core/resources/color_manager.dart';
import 'package:flutter/material.dart';


class ScrollIndicator extends StatelessWidget {
  const ScrollIndicator({
    super.key,
    required this.currentIndex,
    required this.itemLength,
    this.unActiveWidth,
    this.activeWidth,
    this.height,
    this.mainAxisAlignment,
  });

  final int currentIndex;
  final int itemLength;
  final double? unActiveWidth;
  final double? activeWidth;
  final double? height;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: List.generate(itemLength, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: AnimatedContainer(
            height: height ?? 12,
            width: currentIndex == index
                ? activeWidth ?? 60
                : unActiveWidth ?? 18,
            duration: const Duration(milliseconds: 700),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: currentIndex == index
                  ? ColorManager.primaryColor
                  : ColorManager.lightPrimaryColor,
            ),
          ),
        );
      }),
    );
  }
}
