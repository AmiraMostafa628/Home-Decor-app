import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class ChangeHomeNavigationBar extends HomeEvent {
  final int selectedBottomNavbarIndex;

  const ChangeHomeNavigationBar({
    required this.selectedBottomNavbarIndex,
  });

  @override
  List<Object?> get props => [
    selectedBottomNavbarIndex,
  ];
}


class ChangeRadioButtonEvent extends HomeEvent {
  final String selectedPaymentMethod;

  const ChangeRadioButtonEvent({
    required this.selectedPaymentMethod,
  });

  @override
  List<Object?> get props => [
    selectedPaymentMethod,
  ];
}

class SliderEvent extends HomeEvent {

  @override
  List<Object?> get props => [];
}

class CategoriesEvent extends HomeEvent {

  @override
  List<Object?> get props => [
  ];
}

class ProductsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetCurrentUserEvent  extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FilterProductsBasedOnCategory extends HomeEvent {
  final String category;
  final String subCategory;

  const FilterProductsBasedOnCategory({required this.category, required this.subCategory});
}




