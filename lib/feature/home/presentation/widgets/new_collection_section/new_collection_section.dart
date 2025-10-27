import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:decor/feature/home/presentation/widgets/new_collection_section/new_collections_loading_section.dart';
import 'package:decor/feature/home/presentation/widgets/shared/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class NewCollectionSection extends StatelessWidget {
  const NewCollectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.productStatus != current.productStatus ||
          previous.newCollections != current.newCollections ||
          previous.productErrorMessage != current.productErrorMessage,
      builder: (context, state) {
        switch (state.productStatus) {
          case RequestState.initial:
            return SliverToBoxAdapter(
              child: Container(),
            );
          case RequestState.loading:
            return NewCollectionsLoadingSection();
          case RequestState.loaded:
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductItem(
                  product: state.newCollections[index],
                ),
                childCount: state.newCollections.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: .64,
              ),
            );
          case RequestState.error:
            return SliverToBoxAdapter(
              child: Center(
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
              ),
            );
        }
      },
    );
  }
}
