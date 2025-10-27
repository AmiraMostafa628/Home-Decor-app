import 'package:decor/core/components/adaptive_input_field.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/search/presentation/manager/search_bloc.dart';
import 'package:decor/feature/search/presentation/manager/search_event.dart';
import 'package:decor/feature/search/presentation/manager/search_states.dart';
import 'package:decor/feature/search/presentation/pages/search_view_body.dart';
import 'package:decor/feature/search/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchView extends StatelessWidget {
  SearchView({super.key, required this.products, required this.categories,});

  final searchController = TextEditingController();
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: ColorManager.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            SearchBloc(productEntity: products,categories:categories)..add(FetchSearchDataEvent()),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 30,
              children: [
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return AdaptiveInputField(
                      context: context,
                      controller: searchController,
                      hintText: 'Search',
                      prefix: CircleAvatar(
                        child: Icon(
                          Icons.tune,
                          color: ColorManager.blackColor,
                        ),
                      ),
                      prefixPressed: () {
                        final bloc = SearchBloc.get(context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return BlocProvider.value(
                              value:bloc,
                                child: CustomBottomSheet());

                          },
                        );
                      },
                      suffix: CircleAvatar(
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      onSubmit: (value) {
                        SearchBloc.get(context).add(
                         SearchQueryEvent(searchQuery: value)
                        );

                      },
                      suffixPressed: () {
                        SearchBloc.get(context).add(
                            SearchQueryEvent(searchQuery: searchController.text)
                        );

                      },
                      fillColor: Colors.transparent,
                      borderSide: ColorManager.primaryColor,
                      hintTextColor: Colors.grey,
                      heightAfterIt: 20.0,
                      validate: (value) {
                        return null;
                      },
                    );
                  },
                ),
                SearchViewBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
