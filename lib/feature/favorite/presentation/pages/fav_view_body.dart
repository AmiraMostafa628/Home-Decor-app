import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_bloc.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_state.dart';
import 'package:decor/feature/favorite/presentation/widgets/fav_item.dart';
import 'package:decor/feature/favorite/presentation/widgets/fav_loading.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavViewBody extends StatelessWidget {
  const FavViewBody({super.key});


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      body: BlocBuilder<FavBloc, FavState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const CustomAppBar(title: 'Wishlist'),
                const SizedBox(height: 20),
                if (state.fetchFavStatus == RequestState.loading)
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: FavLoading())
                else
                  if (state.fav.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        spacing: 20.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsManager.emptyWishlist),
                          Text(
                            'Your wishList is empty.',
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.fav.length,
                        separatorBuilder: (context,
                            index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final product = state.fav[index];
                          return FavItem(product: product);
                        },
                      ),
                    )
              ],
            ),
          );
        },
      ),
    );
  }

}
