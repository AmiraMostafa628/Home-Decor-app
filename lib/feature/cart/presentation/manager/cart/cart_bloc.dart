import 'dart:async';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/cart/domain/use_cases/toggle_cart_use_case.dart';
import 'package:decor/feature/cart/domain/use_cases/fetch_cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ToggleCartUseCase toggleCartUseCase;
  final FetchCartUseCase fetchCartUseCase;

  static CartBloc get(context)=> BlocProvider.of(context);


  CartBloc(this.toggleCartUseCase, this.fetchCartUseCase)
    : super(CartState(cart: [])) {
    on<ToggleCartEvent>(_addToCart);
    on<FetchCartEvent>(_fetchCart);
  }

  Future<void> _addToCart(ToggleCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(toggleCartStatus: RequestState.loading));

    final result = await toggleCartUseCase.call(param: event.product);


    result.fold(
      (failure) {
        emit(
          state.copyWith(
            toggleCartStatus: RequestState.error,
            addToCartErrorMessage: failure.message,
          ),
        );
      },
      (data) {

        emit(state.copyWith(toggleCartStatus: RequestState.loaded,
          toggleCartMessage: data? 'Added' :"removed",
        ));
      },
    );
  }

  Future<void> _fetchCart(
    FetchCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(fetchCartStatus: RequestState.loading));

    final result = await fetchCartUseCase.call(param: NoParam());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            fetchCartStatus: RequestState.error,
            cartErrorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(state.copyWith(fetchCartStatus: RequestState.loaded, cart: data));
      },
    );
  }
}
