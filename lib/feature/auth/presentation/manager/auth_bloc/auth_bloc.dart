import 'dart:async';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/services/image_services/image_upload.dart';
import 'package:decor/core/services/image_services/pick_image.dart';
import 'package:decor/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:decor/feature/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/auth/domain/use_cases/log_out_use_case.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:intl/intl.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;

  static AuthBloc get(context) => BlocProvider.of(context);

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.logoutUseCase,
  }) : super(AuthState()) {
    on<LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
    on<PickDateEvent>(_showDatePicker);
    on<LoginPasswordVisibilityEvent>(_changeLoginPassVisibility);
    on<SignUpPasswordVisibilityEvent>(_changeSignUpPassVisibility);
    on<SignUpConfirmPasswordVisibilityEvent>(
      _changeSignUpConfirmPassVisibility,
    );
    on<PickImageEvent>(_onPickImage);
    on<UploadImageEvent>(_onUploadImage);
    on<LogoutEvent>(_onLogout);
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginState: RequestState.loading));

    final loginResult = await loginUseCase.call(param: event.loginEntity);

    loginResult.fold(
      (fail) {
        emit(
          state.copyWith(
            loginState: RequestState.error,
            loginErrorMessage: fail.message,
          ),
        );
      },
      (user) {
        emit(state.copyWith(loginData: user, loginState: RequestState.loaded));
      },
    );
  }

  FutureOr<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(logoutState: RequestState.loading));
    try {
      await logoutUseCase.call(param: const NoParam());
      emit(state.copyWith(logoutState: RequestState.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          logoutState: RequestState.error,
          logoutError: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<AuthState> emit,
  ) async {
    final pickedFile = await ImagePickerService.pickImageFromGallery();
    if (pickedFile != null) {
      emit(state.copyWith(profileFile: pickedFile));
      add(UploadImageEvent(pickedFile));
    }
  }

  Future<void> _onUploadImage(
    UploadImageEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final imageUrl = await ImageUploadService.upload(event.imageFile);
      emit(state.copyWith(profileUrl: imageUrl));
    } catch (e) {
      emit(state.copyWith(signUpErrorMessage: e.toString()));
    }
  }

  FutureOr<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signUpState: RequestState.loading));

    try {
      if (state.profileUrl == null) {
        emit(
          state.copyWith(
            signUpState: RequestState.error,
            signUpErrorMessage:
                'Please select a profile image before signing up',
          ),
        );
        return;
      }

      final updatedEntity = event.signUpEntity.copyWith(
        photoUrl: state.profileUrl,
      );

      final result = await signUpUseCase.call(param: updatedEntity);

      result.fold(
        (fail) => emit(
          state.copyWith(
            signUpState: RequestState.error,
            signUpErrorMessage: fail.message,
          ),
        ),
        (user) => emit(
          state.copyWith(signUpData: user, signUpState: RequestState.loaded),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          signUpState: RequestState.error,
          signUpErrorMessage: 'Image upload failed: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _showDatePicker(
    PickDateEvent event,
    Emitter<AuthState> emit,
  ) async {
    late String formattedDate = '';
    DateTime? pickedDate = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
    emit(state.copyWith(date: formattedDate));
  }

  bool loginPassVisible = true;

  FutureOr<void> _changeLoginPassVisibility(
    LoginPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    loginPassVisible = !loginPassVisible;
    emit(state.copyWith(loginPasswordVisibility: loginPassVisible));
  }

  bool signUpPassVisible = true;

  FutureOr<void> _changeSignUpPassVisibility(
    SignUpPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    signUpPassVisible = !signUpPassVisible;
    emit(state.copyWith(signUpPasswordVisibility: signUpPassVisible));
  }

  bool signUpConfirmPassVisible = true;

  FutureOr<void> _changeSignUpConfirmPassVisibility(
    SignUpConfirmPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    signUpConfirmPassVisible = !signUpConfirmPassVisible;
    emit(
      state.copyWith(signUpConfirmPasswordVisibility: signUpConfirmPassVisible),
    );
  }
}
