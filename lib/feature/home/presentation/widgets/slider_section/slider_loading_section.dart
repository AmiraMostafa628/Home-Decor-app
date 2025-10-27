import 'package:decor/core/components/main_carousel_slider.dart';
import 'package:decor/feature/home/domain/entities/slider_entity.dart';
import 'package:decor/feature/home/presentation/widgets/slider_section/scroll_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliderLoadingSection extends StatelessWidget {
  const SliderLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: MainCarouselSlider(
        items: List.generate(4, (index) {
          return ScrollItemBuilder(
            itemLength: 3,
            item: SliderEntity(
                id: index,
                image: 'i$index',
            ),
            currentIndex: index,
          );
        }),
        options: CarouselOptions(
          autoPlay: true,
          height: 225,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
