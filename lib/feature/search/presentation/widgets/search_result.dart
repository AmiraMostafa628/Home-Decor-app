import 'package:decor/feature/home/presentation/widgets/shared/product_item.dart';
import 'package:decor/feature/search/presentation/manager/search_bloc.dart';
import 'package:decor/feature/search/presentation/manager/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          childAspectRatio: .64,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(
              state.products?.length ?? 0, (index) {
            return ProductItem(product: state.products![index],);
          }),
        );
      },
    );
  }
}
