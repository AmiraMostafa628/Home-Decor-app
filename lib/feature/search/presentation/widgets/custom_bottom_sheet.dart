import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/search/presentation/manager/search_bloc.dart';
import 'package:decor/feature/search/presentation/manager/search_event.dart';
import 'package:decor/feature/search/presentation/manager/search_states.dart';
import 'package:decor/feature/search/presentation/widgets/categories.dart';
import 'package:decor/feature/search/presentation/widgets/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height *0.8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                spacing: 20.0,
                children: [
                  Text(
                    'Filter',
                    style: textTheme.headlineMedium!.copyWith(
                      color: ColorManager.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    padding: EdgeInsets.zero,
                    min: state.minPrice.toDouble(),
                    max: state.maxPrice.toDouble(),
                    inactiveColor: ColorManager.lightPrimaryColor,
                    value: state.priceValue,
                    divisions: 100,
                    onChanged: (value) {
                      SearchBloc.get(
                        context,
                      ).add(ChangePriceValueEvent(priceValue: value));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${state.minPrice.toString()}',
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        '\$${state.maxPrice.toString()}',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Categories(),
                  SubCategories(),
                  CustomTextButton(
                    width: 250,
                    onPressed: () {
                      SearchBloc.get(context).add(ApplyFiltersEvent());

                      Navigator.of(context).pop();
                    },
                    text: 'Apply',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
