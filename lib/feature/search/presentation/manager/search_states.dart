import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final RequestState searchStatus;
  final List<ProductEntity>? products;
  final String searchErrorMessage;
  final double priceValue;
  final List<String>? categories;
  final String? selectedCategory;
  final int? selectedCategoriesIndex;
  final String? selectedSubCategory;
  final int? selectedSubCategoriesIndex;
  final List<String>? subCategories;
  final String? searchQuery;
  final num minPrice;
  final num maxPrice;

  const SearchState({
    this.searchStatus = RequestState.initial,
    this.products,
    this.searchErrorMessage = '',
    this.priceValue = 4000,
    this.categories,
    this.selectedCategoriesIndex,
    this.selectedCategory,
    this.selectedSubCategory,
    this.selectedSubCategoriesIndex,
    this.subCategories,
    this.searchQuery = '',
    this.minPrice = 4000,
    this.maxPrice = 11000,
  });

  SearchState copyWith({
    RequestState? searchStatus,
    List<ProductEntity>? products,
    String? searchErrorMessage,
    double? priceValue,
    List<String>? categories,
    String? selectedCategory,
    int? selectedCategoriesIndex,
    String? selectedSubCategory,
    int? selectedSubCategoriesIndex,
    List<String>? subCategories,
    String? searchQuery,
    num? minPrice,
    num? maxPrice,
  }) {
    return SearchState(
      searchStatus: searchStatus ?? this.searchStatus,
      products: products ?? this.products,
      searchErrorMessage: searchErrorMessage ?? this.searchErrorMessage,
      priceValue: priceValue ?? this.priceValue,
      categories:  categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCategoriesIndex: selectedCategoriesIndex?? this.selectedCategoriesIndex,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      selectedSubCategoriesIndex:
          selectedSubCategoriesIndex ?? this.selectedSubCategoriesIndex,
      subCategories: subCategories ?? this.subCategories,
      searchQuery: searchQuery ?? this.searchQuery,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
    searchStatus,
    products,
    searchErrorMessage,
    priceValue,
    categories,
    selectedCategory,
    selectedCategoriesIndex,
    selectedSubCategory,
    selectedSubCategoriesIndex,
    subCategories,
    searchQuery,
    minPrice,
    maxPrice,
  ];
}
