import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class FetchSearchDataEvent extends SearchEvent {}

// class ApplyFiltersEvent extends SearchEvent {
//   final String? searchQuery;
//   final double? priceValue;
//   final String? selectedSubCategory;
//   final int? selectedSubCategoriesIndex;
//
//   const ApplyFiltersEvent({required this.searchQuery, required this.priceValue, required this.selectedSubCategory, required this.selectedSubCategoriesIndex});
//
//
//
//   @override
//   List<Object?> get props => [
//     searchQuery,
//     priceValue,
//     selectedSubCategory,
//     selectedSubCategoriesIndex,
//   ];
// }

class ApplyFiltersEvent extends SearchEvent {}


class SearchQueryEvent extends SearchEvent {
  final String searchQuery;

  const SearchQueryEvent({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class ChangePriceValueEvent extends SearchEvent {
  final double priceValue;

  const ChangePriceValueEvent({required this.priceValue});

  @override
  List<Object?> get props => [priceValue];
}

class SelectCategoryEvent extends SearchEvent {
  final String selectedCategory;
  final int selectedCategoriesIndex;

  const SelectCategoryEvent({
    required this.selectedCategory,
    required this.selectedCategoriesIndex,
  });

  @override
  List<Object?> get props => [selectedCategory, selectedCategoriesIndex];
}

class SelectSubCategoryEvent extends SearchEvent {
  final String selectedSubCategory;
  final int selectedSubCategoriesIndex;

  const SelectSubCategoryEvent({
    required this.selectedSubCategory,
    required this.selectedSubCategoriesIndex,
  });

  @override
  List<Object?> get props => [selectedSubCategory, selectedSubCategoriesIndex];
}

class SelectIsBestSellerEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}
