import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/entities/notification_setting.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/domain/entities/slider_entity.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final int selectedBottomNavbarIndex;
  final String selectedPaymentMethod;
  final RequestState sliderStatus;
  final String sliderErrorMessage;
  final List<SliderEntity> slider;
  final RequestState categoriesStatus;
  final String categoriesErrorMessage;
  final List<CategoryEntity> categories;
  final RequestState productStatus;
  final String productErrorMessage;
  final List<ProductEntity> products;
  final List<ProductEntity> bestSeller;
  final List<ProductEntity> newCollections;
  final List<ProductEntity> filteredProducts;
  final RequestState currentUserStatus;
  final UserEntity currentUser;
  final String currentUserError;
  final List<NotificationSetting> settings;

  const HomeState({
    this.selectedBottomNavbarIndex = 0,
    required this.selectedPaymentMethod,
    this.sliderStatus = RequestState.initial,
    this.sliderErrorMessage = '',
    required this.slider,
    this.categoriesStatus = RequestState.initial,
    this.categoriesErrorMessage = '',
    required this.categories,
    this.productStatus = RequestState.initial,
    this.productErrorMessage = '',
    required this.products,
    required this.bestSeller,
    required this.newCollections,
    required this.filteredProducts,
    this.currentUserStatus = RequestState.initial,
    this.currentUser = UserEntity.empty,
    this.currentUserError = '',
    required this.settings,
  });

  HomeState copyWith({
    int? selectedBottomNavbarIndex,
    String? selectedPaymentMethod,
    RequestState? sliderStatus,
    String? sliderErrorMessage,
    List<SliderEntity>? slider,
    RequestState? categoriesStatus,
    String? categoriesErrorMessage,
    List<CategoryEntity>? categories,
    RequestState? productStatus,
    String? productErrorMessage,
    List<ProductEntity>? products,
    List<ProductEntity>? bestSeller,
    List<ProductEntity>? newCollections,
    List<ProductEntity>? filteredProducts,
    RequestState? currentUserStatus,
    UserEntity? currentUser,
    String? currentUserError,
    List<NotificationSetting>? settings,
  }) {
    return HomeState(
      selectedBottomNavbarIndex:
          selectedBottomNavbarIndex ?? this.selectedBottomNavbarIndex,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      sliderStatus: sliderStatus ?? this.sliderStatus,
      sliderErrorMessage: sliderErrorMessage ?? this.sliderErrorMessage,
      slider: slider ?? this.slider,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesErrorMessage: categoriesErrorMessage ?? this.sliderErrorMessage,
      categories: categories ?? this.categories,
      productStatus: productStatus ?? this.productStatus,
      productErrorMessage: productErrorMessage ?? this.productErrorMessage,
      products: products ?? this.products,
      bestSeller: bestSeller ?? this.bestSeller,
      newCollections: newCollections ?? this.newCollections,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      currentUserStatus: currentUserStatus ?? this.currentUserStatus,
      currentUser: currentUser ?? this.currentUser,
      currentUserError: currentUserError ?? this.currentUserError,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [
    selectedBottomNavbarIndex,
    selectedPaymentMethod,
    sliderStatus,
    sliderErrorMessage,
    slider,
    categoriesStatus,
    categoriesErrorMessage,
    categories,
    productStatus,
    productErrorMessage,
    products,
    bestSeller,
    newCollections,
    filteredProducts,
    currentUserStatus,
    currentUser,
    currentUserError,
    settings
  ];
}
