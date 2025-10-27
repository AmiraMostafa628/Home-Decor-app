import 'package:equatable/equatable.dart';

abstract class ChangeThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ChangeThemeEvent {}
