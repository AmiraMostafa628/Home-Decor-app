import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable{}

class ToggleCartEvent extends CartEvent {
  final ProductEntity product;

  ToggleCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class FetchCartEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}