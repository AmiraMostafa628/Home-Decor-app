import 'dart:io';

import 'package:decor/feature/auth/domain/entities/login_entity.dart';
import 'package:decor/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final LoginEntity loginEntity;

  const LoginEvent({required this.loginEntity});

  @override
  List<Object?> get props => [loginEntity];
}

class SignUpEvent extends AuthEvent {
  final SignUpEntity signUpEntity;

  const SignUpEvent({required this.signUpEntity});

  @override
  List<Object?> get props => [signUpEntity];
}

class PickDateEvent extends AuthEvent {
  final BuildContext context;

  const PickDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class LoginPasswordVisibilityEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpPasswordVisibilityEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpConfirmPasswordVisibilityEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class PickImageEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class UploadImageEvent extends AuthEvent {
  final File imageFile;

  const UploadImageEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
