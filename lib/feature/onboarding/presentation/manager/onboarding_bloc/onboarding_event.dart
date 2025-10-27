import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class ChangeCurrentOnboardingIndexEvent extends OnboardingEvent {
  final int currentIndex;

  const ChangeCurrentOnboardingIndexEvent({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}
