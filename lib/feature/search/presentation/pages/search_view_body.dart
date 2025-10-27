import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/home/presentation/widgets/new_collection_section/new_collections_loading_section.dart';
import 'package:decor/feature/search/presentation/manager/search_bloc.dart';
import 'package:decor/feature/search/presentation/manager/search_states.dart';
import 'package:decor/feature/search/presentation/widgets/empty_search.dart';
import 'package:decor/feature/search/presentation/widgets/search_error.dart';
import 'package:decor/feature/search/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.searchStatus) {
          case RequestState.initial:
            return Container();
          case RequestState.loading:
            return NewCollectionsLoadingSection();
          case RequestState.loaded:
            return state.products!.isEmpty
                ? Center(child: EmptySearch(errMessage: state.searchErrorMessage))
                : SearchResult();
          case RequestState.error:
            return Center(child: SearchError(errMessage: state.searchErrorMessage));
        }
      },
    );
  }
}
