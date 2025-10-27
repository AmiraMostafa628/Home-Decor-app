import 'package:decor/core/components/main_carousel_slider.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:decor/feature/home/presentation/widgets/slider_section/scroll_item_builder.dart';
import 'package:decor/feature/home/presentation/widgets/slider_section/slider_loading_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
      previous.sliderStatus != current.sliderStatus ||
          previous.slider != current.slider ||
          previous.sliderErrorMessage != current.sliderErrorMessage,
      builder: (context, state) {
        final data = state.slider;
        switch(state.sliderStatus) {
          case RequestState.initial:
            return Container();
          case RequestState.loading:
            return SliderLoadingSection();
          case RequestState.loaded:
          return MainCarouselSlider(
            items: data.asMap().entries.map((entry) {
              final index = entry.key;
              final item  = entry.value;
              return ScrollItemBuilder(
                item: item,
                itemLength: data.length,
                currentIndex: index,
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: 225,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
            ),
          );
          case RequestState.error:
            return Center(
              child: Column(
                spacing: 10.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AssetsManager.error,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    state.sliderErrorMessage,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}


