import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/search/presentation/manager/search_bloc.dart';
import 'package:decor/feature/search/presentation/manager/search_event.dart';
import 'package:decor/feature/search/presentation/manager/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: textTheme.bodyLarge!.copyWith(
                color: ColorManager.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              children: state.categories!
                  .asMap()
                  .entries
                  .map((entry) {
                int index = entry.key;
                var item = entry.value;
                bool selectedIndex =
                    index == state.selectedCategoriesIndex;
                return GestureDetector(
                  onTap: () {
                    SearchBloc.get(context).add(
                      SelectCategoryEvent(
                        selectedCategory: item,
                        selectedCategoriesIndex: index,

                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex
                          ? ColorManager.darkPrimaryColor
                          : ColorManager.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      item,
                      style: textTheme.bodyLarge!.copyWith(
                        color: ColorManager.hintTextColor,
                      ),
                    ),
                  ),
                );
              })
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
