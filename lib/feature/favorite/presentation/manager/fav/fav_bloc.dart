import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/favorite/domain/use_cases/toggle_fav_use_case.dart';
import 'package:decor/feature/favorite/domain/use_cases/fetch_fav_use_case.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_event.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  final ToggleFavUseCase toggleFavUseCase;
  final FetchFavUseCase fetchFavUseCase;

  static FavBloc get(context) => BlocProvider.of(context);

  FavBloc(this.toggleFavUseCase, this.fetchFavUseCase)
    : super(FavState(fav: [])) {
    on<ToggleFavEvent>(_addToFav);
    on<FetchFavEvent>(_fetchFav);
  }

  Future<void> _addToFav(ToggleFavEvent event, Emitter<FavState> emit) async {
    emit(state.copyWith(toggleFavStatus: RequestState.loading));

    final result = await toggleFavUseCase.call(param: event.product);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            toggleFavStatus: RequestState.error,
            addToFavErrorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            toggleFavStatus: RequestState.loaded,
            toggleFavMessage: data ? 'Added' : 'removed',
          ),
        );
      },
    );
  }

  Future<void> _fetchFav(FetchFavEvent event, Emitter<FavState> emit) async {
    emit(state.copyWith(fetchFavStatus: RequestState.loading));

    final result = await fetchFavUseCase.call(param: NoParam());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            fetchFavStatus: RequestState.error,
            favErrorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(state.copyWith(fetchFavStatus: RequestState.loaded, fav: data));
      },
    );
  }
}
