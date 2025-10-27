import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_event.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:decor/feature/home/presentation/widgets/shared/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoriesView extends StatelessWidget {
  const SubCategoriesView({
    super.key,
    required this.category,
  });

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeBloc.get(context).add(
        FilterProductsBasedOnCategory(
          category: category.name,
          subCategory: category.subcategories[0],
        ),
      );
    });

    final textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CustomAppBar(title: category.name),
              const SizedBox(height: 25.0),
              Wrap(
                spacing: 8,
                children:
                category.subcategories
                    .map((sub) {
                  return GestureDetector(
                    onTap: () {
                      HomeBloc.get(context).add(
                        FilterProductsBasedOnCategory(
                          category: category.name,
                          subCategory: sub,
                        ),
                      );
                    },
                    child: Text(
                      sub,
                      style: textTheme.bodyMedium!.copyWith(
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  );
                })
                    .expand((widget) => [widget, Text('|')])
                    .toList()
                  ..removeLast(),
              ),
              SizedBox(height: 25.0,),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: .65,
                      ),
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductItem(product: state.filteredProducts[index] );
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
