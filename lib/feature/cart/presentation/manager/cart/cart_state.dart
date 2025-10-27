import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final RequestState toggleCartStatus;
  final String toggleCartMessage;
  final RequestState fetchCartStatus;
  final List<ProductEntity> cart;
  final String addToCartErrorMessage;
  final String cartErrorMessage;

  const CartState({
    this.toggleCartStatus = RequestState.initial,
    this.toggleCartMessage = '',
    this.fetchCartStatus = RequestState.initial,
    required this.cart,
    this.addToCartErrorMessage = '',
    this.cartErrorMessage = '',
  });

  CartState copyWith({
    RequestState? toggleCartStatus,
    String? toggleCartMessage,
    RequestState? fetchCartStatus,
    List<ProductEntity>? cart,
    String? addToCartErrorMessage,
    String? cartErrorMessage,
  }) {
    return CartState(
      toggleCartStatus: toggleCartStatus ?? this.toggleCartStatus,
      toggleCartMessage: toggleCartMessage ?? this.toggleCartMessage,
      fetchCartStatus: fetchCartStatus ?? this.fetchCartStatus,
      cart: cart ?? this.cart,
      cartErrorMessage: cartErrorMessage ?? this.cartErrorMessage,
      addToCartErrorMessage: addToCartErrorMessage ?? this.addToCartErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    toggleCartStatus,
    toggleCartMessage,
    fetchCartStatus,
    cart,
    addToCartErrorMessage,
    cartErrorMessage,
  ];
}
