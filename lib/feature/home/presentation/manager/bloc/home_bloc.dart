import 'dart:async';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/app_constants.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/domain/use_cases/category_use_case.dart';
import 'package:decor/feature/home/domain/use_cases/get_current_user_use_case.dart';
import 'package:decor/feature/home/domain/use_cases/product_use_case.dart';
import 'package:decor/feature/home/domain/use_cases/slider_use_case.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_event.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static HomeBloc get(context) => BlocProvider.of(context);
  final SliderUseCase sliderUseCase;
  final CategoryUseCase categoriesUseCase;
  final ProductUseCase productUseCase;
  final GetCurrentUserUseCase currentUserUseCase;

  HomeBloc(
    this.sliderUseCase,
    this.categoriesUseCase,
    this.productUseCase,
    this.currentUserUseCase,
  ) : super(
        HomeState(
          slider: [],
          categories: [],
          bestSeller: [],
          newCollections: [],
          products: [],
          filteredProducts: [],
          settings: AppConstants.notifications,
          selectedPaymentMethod: AppConstants.paymentMethodItems.first.method,
        ),
      ) {
    on<ChangeHomeNavigationBar>(_changeNavBarIndex);
    on<ChangeRadioButtonEvent>(_changeRadioButtonIndex);
    on<SliderEvent>(_sliderData);
    on<CategoriesEvent>(_categoriesData);
    on<ProductsEvent>(_productsData);
    on<GetCurrentUserEvent>(_getCurrentUser);
    on<FilterProductsBasedOnCategory>(_filterProduct);
  }

  FutureOr<void> _changeNavBarIndex(
    ChangeHomeNavigationBar event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        selectedBottomNavbarIndex: event.selectedBottomNavbarIndex,
      ),
    );
  }

  FutureOr<void> _changeRadioButtonIndex(
    ChangeRadioButtonEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(selectedPaymentMethod: event.selectedPaymentMethod),
    );
  }

  Future<void> _sliderData(SliderEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(sliderStatus: RequestState.loading));
    final result = await sliderUseCase.call(param: NoParam());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            sliderStatus: RequestState.error,
            sliderErrorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(state.copyWith(slider: data, sliderStatus: RequestState.loaded));
      },
    );
  }

  Future<void> _categoriesData(
    CategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoriesStatus: RequestState.loading));
    final result = await categoriesUseCase.call(param: NoParam());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoriesStatus: RequestState.error,
            categoriesErrorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            categories: data,
            categoriesStatus: RequestState.loaded,
          ),
        );
      },
    );
  }

  Future<void> _productsData(
    ProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(productStatus: RequestState.loading));
    final result = await productUseCase.call(param: NoParam());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            productStatus: RequestState.error,
            productErrorMessage: failure.message,
          ),
        );
      },
      (data) {
        List<ProductEntity> bestSellerProducts = data
            .where((e) => e.isBestSeller == true)
            .toList();
        List<ProductEntity> newCollectionsProducts = data
            .where((e) => e.isNewCollection == true)
            .toList();
        emit(
          state.copyWith(
            productStatus: RequestState.loaded,
            products: data,
            bestSeller: bestSellerProducts,
            newCollections: newCollectionsProducts,
          ),
        );
      },
    );
  }

  FutureOr<void> _getCurrentUser(
    GetCurrentUserEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await currentUserUseCase.call(param: NoParam());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            currentUserStatus: RequestState.error,
            currentUserError: failure.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            currentUser: data,
            currentUserStatus: RequestState.loaded,
          ),
        );
      },
    );
  }

  FutureOr<void> _filterProduct(event, Emitter<HomeState> emit) {
    final filtered = state.products
        .where(
          (product) =>
              product.category == event.category &&
              product.subcategory == event.subCategory,
        )
        .toList();

    emit(state.copyWith(filteredProducts: filtered));
  }


}
