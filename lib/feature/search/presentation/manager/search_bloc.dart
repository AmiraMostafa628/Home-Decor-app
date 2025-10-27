import 'dart:async';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/search/presentation/manager/search_event.dart';
import 'package:decor/feature/search/presentation/manager/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static SearchBloc get(context) => BlocProvider.of(context);
  final List<ProductEntity> productEntity;
  final List<CategoryEntity> categories;

  SearchBloc({required this.productEntity, required this.categories})
    : super(SearchState()) {
    on<FetchSearchDataEvent>(_getData);
    on<SearchQueryEvent>(_changeSearchValue);
    on<ChangePriceValueEvent>(_changePriceValue);
    on<SelectCategoryEvent>(_selectCategory);
    on<SelectSubCategoryEvent>(_selectSubCategory);
    on<ApplyFiltersEvent>(_applyFilters);
  }

  FutureOr<void> _getData(
    FetchSearchDataEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(searchStatus: RequestState.loading));

    try {
      final allSubcategories = categories
          .expand((cat) => cat.subcategories)
          .toList();
      final uniqueSubcategories = allSubcategories
          .toSet()
          .toList()
          .cast<String>();

      final allCategories = categories.map((category)=> category.name).toList();

      final minPrice = productEntity.isNotEmpty
          ? productEntity.map((p) => p.price).reduce((a, b) => a < b ? a : b)
          : 0;
      final maxPrice = productEntity.isNotEmpty
          ? productEntity.map((p) => p.price).reduce((a, b) => a > b ? a : b)
          : 11000;

      emit(
        state.copyWith(
          searchStatus: RequestState.loaded,
          products: productEntity,
          categories: allCategories,
          subCategories: uniqueSubcategories,
          minPrice: minPrice,
          maxPrice: maxPrice,
          priceValue: maxPrice.toDouble(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          searchStatus: RequestState.error,
          searchErrorMessage: 'Failed to load products: $e',
        ),
      );
    }
  }

  FutureOr<void> _changeSearchValue(
    SearchQueryEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(
      state.copyWith(
        searchQuery: event.searchQuery,
        searchStatus: RequestState.loading,
      ),
    );
    _applyAllFilters(emit);
  }

  FutureOr<void> _changePriceValue(
    ChangePriceValueEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(priceValue: event.priceValue));
    _applyAllFilters(emit);
  }

  FutureOr<void> _selectCategory(
    SelectCategoryEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(
      state.copyWith(
        selectedCategory: event.selectedCategory,
        selectedCategoriesIndex: event.selectedCategoriesIndex,
      ),
    );
    _applyAllFilters(emit);
  }

  FutureOr<void> _selectSubCategory(
      SelectSubCategoryEvent event,
      Emitter<SearchState> emit,
      ) {
    emit(
      state.copyWith(
        selectedSubCategory: event.selectedSubCategory,
        selectedSubCategoriesIndex: event.selectedSubCategoriesIndex,
      ),
    );
    _applyAllFilters(emit);
  }

  FutureOr<void> _applyFilters(
    ApplyFiltersEvent event,
    Emitter<SearchState> emit,
  ) {
    _applyAllFilters(emit);
  }

  void _applyAllFilters(Emitter<SearchState> emit) {
    emit(state.copyWith(searchStatus: RequestState.loading));

    try {
      List<ProductEntity> filtered = List.from(productEntity);

      if (state.searchQuery != null && state.searchQuery!.trim().isNotEmpty) {
        final query = state.searchQuery!.toLowerCase().trim();
        filtered = filtered
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query),
            )
            .toList();
      }

      if (state.priceValue > 0) {
        filtered = filtered
            .where((product) => product.price <= state.priceValue)
            .toList();
      }

      if (state.selectedCategory != null &&
          state.selectedCategory!.trim().isNotEmpty) {
        filtered = filtered
            .where(
              (product) => product.category == state.selectedCategory,
            )
            .toList();
      }
      if (state.selectedSubCategory != null &&
          state.selectedSubCategory!.trim().isNotEmpty) {
        filtered = filtered
            .where(
              (product) => product.subcategory == state.selectedSubCategory,
            )
            .toList();
      }

      if (filtered.isNotEmpty ||
          (state.searchQuery?.isEmpty ?? true) &&
              state.priceValue >= state.maxPrice &&
              (state.selectedCategory?.isEmpty ?? true) &&
              (state.selectedSubCategory?.isEmpty ?? true)) {
        emit(
          state.copyWith(products: filtered, searchStatus: RequestState.loaded),
        );
      } else {
        emit(
          state.copyWith(
            products: [],
            searchStatus: RequestState.loaded,
            searchErrorMessage: 'No products match your filters',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          searchStatus: RequestState.error,
          searchErrorMessage: 'Error applying filters: $e',
        ),
      );
    }
  }
}
