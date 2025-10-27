import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${state.currentUser.userName}',
                  style: textTheme.titleMedium!.copyWith(
                    color: ColorManager.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ), Text('Create spaces that bring joy',
                    style: textTheme.bodyMedium),
              ],
            ),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kSearchView, extra: [state.products,state.categories]);
              },
              child: CircleAvatar(
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
                child: Icon(
                  Icons.search,
                  color: ColorManager.whiteColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
