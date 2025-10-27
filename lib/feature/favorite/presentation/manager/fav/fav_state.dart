import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class FavState extends Equatable {
  final RequestState toggleFavStatus;
  final String toggleFavMessage;
  final RequestState fetchFavStatus;
  final List<ProductEntity> fav;
  final String addToFavErrorMessage;
  final String favErrorMessage;

  const FavState({
    this.toggleFavStatus = RequestState.initial,
    this.toggleFavMessage = '',
    this.fetchFavStatus = RequestState.initial,
    required this.fav,
    this.addToFavErrorMessage = '',
    this.favErrorMessage = '',
  });

  FavState copyWith({
    RequestState? toggleFavStatus,
    String? toggleFavMessage,
    RequestState? fetchFavStatus,
    List<ProductEntity>? fav,
    String? addToFavErrorMessage,
    String? favErrorMessage,
  }) {
    return FavState(
      toggleFavStatus: toggleFavStatus ?? this.toggleFavStatus,
      toggleFavMessage: toggleFavMessage ?? this.toggleFavMessage,
      fetchFavStatus: fetchFavStatus ?? this.fetchFavStatus,
      fav: fav ?? this.fav,
      favErrorMessage: favErrorMessage ?? this.favErrorMessage,
      addToFavErrorMessage: addToFavErrorMessage ?? this.addToFavErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    toggleFavStatus,
    toggleFavMessage,
    fetchFavStatus,
    fav,
    addToFavErrorMessage,
    favErrorMessage,
  ];
}
