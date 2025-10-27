import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:decor/feature/home/presentation/widgets/best_seller_section/best_seller_item.dart';
import 'package:decor/feature/home/presentation/widgets/best_seller_section/best_seller_loading_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key});

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
      previous.productStatus != current.productStatus||
        previous.bestSeller != current.bestSeller ||
        previous.productErrorMessage != current.productErrorMessage,
      builder: (context, state) {
        final data = state.bestSeller;
        switch(state.productStatus) {
          case RequestState.initial:
            return Container();
          case RequestState.loading:
            return BestSellerLoadingSection();
          case RequestState.loaded:
            return SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return BestSellerItem(bestSeller: data[index]);
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: 20.0,
                ),
                itemCount: data.length,
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
                    state.productErrorMessage,
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
