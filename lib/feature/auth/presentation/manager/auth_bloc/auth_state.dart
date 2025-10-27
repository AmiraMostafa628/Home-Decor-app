import 'dart:io';

import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:decor/core/enums/request_state.dart';

class AuthState extends Equatable {
  final String date;
  final RequestState loginState;
  final String? loginErrorMessage;
  final UserEntity? loginData;
  final RequestState signUpState;
  final String? signUpErrorMessage;
  final UserEntity? signUpData;
  final bool loginPasswordVisibility;
  final bool signUpPasswordVisibility;
  final bool signUpConfirmPasswordVisibility;
  final File? profileFile;
  final String? profileUrl;
  final RequestState logoutState;
  final String? logoutError;

  const AuthState({
    this.date = '',
    this.loginState = RequestState.initial,
    this.loginErrorMessage,
    this.loginData,
    this.signUpState = RequestState.initial,
    this.signUpErrorMessage,
    this.signUpData,
    this.loginPasswordVisibility = true,
    this.signUpPasswordVisibility = true,
    this.signUpConfirmPasswordVisibility = true,
    this.profileFile,
    this.profileUrl,
    this.logoutState = RequestState.initial,
    this.logoutError,
  });

  AuthState copyWith({
    dynamic date,
    RequestState? loginState,
    dynamic loginErrorMessage,
    UserEntity? loginData,
    RequestState? signUpState,
    dynamic signUpErrorMessage,
    UserEntity? signUpData,
    bool? loginPasswordVisibility,
    bool? signUpPasswordVisibility,
    bool? signUpConfirmPasswordVisibility,
    File? profileFile,
    String? profileUrl,
    RequestState? logoutState,
    String? logoutError,
  }) {
    return AuthState(
      date: date ?? this.date,
      loginState: loginState ?? this.loginState,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      loginData: loginData ?? this.loginData,
      signUpState: signUpState ?? this.signUpState,
      signUpErrorMessage: signUpErrorMessage ?? this.signUpErrorMessage,
      signUpData: signUpData ?? this.signUpData,
      loginPasswordVisibility:
          loginPasswordVisibility ?? this.loginPasswordVisibility,
      signUpPasswordVisibility:
          signUpPasswordVisibility ?? this.signUpPasswordVisibility,
      signUpConfirmPasswordVisibility:
          signUpConfirmPasswordVisibility ??
          this.signUpConfirmPasswordVisibility,
      profileFile: profileFile ?? this.profileFile,
      profileUrl: profileUrl ?? this.profileUrl,
      logoutState: logoutState ?? this.logoutState,
      logoutError: logoutError ?? this.logoutError,
    );
  }

  @override
  List<Object?> get props => [
    date,
    loginState,
    loginErrorMessage,
    loginData,
    signUpState,
    signUpErrorMessage,
    signUpData,
    loginPasswordVisibility,
    signUpPasswordVisibility,
    signUpConfirmPasswordVisibility,
    profileFile,
    profileUrl,
    logoutState,
    logoutError,
  ];
}
