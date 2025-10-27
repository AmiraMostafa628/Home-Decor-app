import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_theme_event.dart';
import 'change_theme_state.dart';

class ChangeThemeBloc extends Bloc<ChangeThemeEvent, ChangeThemeState> {
  static ChangeThemeBloc get(context) => BlocProvider.of(context);

  ChangeThemeBloc() : super(const ChangeThemeState(isDark: false)) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  FutureOr<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ChangeThemeState> emit,
  ) {
    emit(state.copyWith(isDark: !state.isDark));
  }
}
