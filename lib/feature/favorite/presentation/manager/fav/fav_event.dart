import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavEvent extends Equatable{}

class ToggleFavEvent extends FavEvent {
  final ProductEntity product;

  ToggleFavEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class FetchFavEvent extends FavEvent{
  @override
  List<Object?> get props => [];
}