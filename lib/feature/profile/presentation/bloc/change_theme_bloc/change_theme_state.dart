import 'package:equatable/equatable.dart';

class ChangeThemeState extends Equatable {
  final bool isDark;

  const ChangeThemeState({required this.isDark});

  ChangeThemeState copyWith({bool? isDark}) {
    return ChangeThemeState(isDark: isDark ?? this.isDark);
  }

  @override
  List<Object?> get props => [isDark];
}
