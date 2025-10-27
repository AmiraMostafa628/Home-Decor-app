import 'package:decor/core/components/custom_image.dart';
import 'package:decor/core/components/scroll_indicator.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/home/domain/entities/slider_entity.dart';
import 'package:flutter/material.dart';


class ScrollItemBuilder extends StatelessWidget {
  const ScrollItemBuilder({
    super.key,
    required this.itemLength,
    required this.item,
    required this.currentIndex,
  });

  final SliderEntity item;
  final int itemLength;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: ColorManager.primaryColor,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomImage(
              imageType: ImagesType.network,
              imagePath: item.image,
            ),

          ),
        ),

        ScrollIndicator(
          mainAxisAlignment: MainAxisAlignment.center,
          currentIndex: currentIndex,
          itemLength: itemLength,
          unActiveWidth: 50.0,
          activeWidth: 50,
          height: 8,
        ),
      ],
    );
  }
}
