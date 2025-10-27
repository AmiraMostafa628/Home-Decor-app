import 'package:decor/core/resources/app_constants.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_event.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
   const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: IndexedStack(
              index:state.selectedBottomNavbarIndex,
              children: AppConstants.screens,
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
        previous.selectedBottomNavbarIndex != current.selectedBottomNavbarIndex,
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state.selectedBottomNavbarIndex,
            destinations: AppConstants.destinationsItems,
            onDestinationSelected: (index) {
              HomeBloc.get(context).add(
                ChangeHomeNavigationBar(
                  selectedBottomNavbarIndex: index,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
