import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  static OnboardingBloc get(context) => BlocProvider.of(context);

  OnboardingBloc() : super(OnboardingState()) {
    on<ChangeCurrentOnboardingIndexEvent>(_changeCurrentOnboardingIndex);
  }

  FutureOr<void> _changeCurrentOnboardingIndex(
    ChangeCurrentOnboardingIndexEvent event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.currentIndex));
  }
}
