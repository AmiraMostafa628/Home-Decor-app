import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:decor/feature/home/presentation/widgets/categories_section/categories_view_loading.dart';
import 'package:decor/feature/home/presentation/widgets/categories_section/grid_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});


  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CustomAppBar(title: 'Categories'),
          const SizedBox(height: 25.0),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if(state.categoriesStatus ==RequestState.loaded){
                  return GridSection(categories: state.categories,);
                }
                else{
                  return CategoriesViewLoading();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


