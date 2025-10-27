import 'package:decor/feature/home/domain/entities/notification_setting.dart';
import 'package:equatable/equatable.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';

class ProfileState extends Equatable {
  final UserEntity? currentUser;
  final RequestState userProfileState;
  final String userProfileError;
  final String selectedPaymentMethod;
  final List<NotificationSetting> settings;
  final String? cvc;
  final String? name;
  final String? number;
  final String? expireDate;

  const ProfileState({
    this.currentUser,
    this.userProfileState = RequestState.initial,
    this.userProfileError = '',
    required this.selectedPaymentMethod,
    this.cvc,
    this.name,
    this.number,
    this.expireDate,
    required this.settings,

  });

  ProfileState copyWith({
    UserEntity? currentUser,
    RequestState? userProfileState,
    String? userProfileError,
    String? selectedPaymentMethod,
    String? cvc,
    String? name,
    String? number,
    String? expireDate,
    List<NotificationSetting>? settings,

  }) {
    return ProfileState(
      currentUser: currentUser ?? this.currentUser,
      userProfileState: userProfileState ?? this.userProfileState,
      userProfileError: userProfileError ?? this.userProfileError,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      cvc: cvc ?? this.cvc,
      name: name ?? this.name,
      number: number ?? this.number,
      expireDate: expireDate ?? this.expireDate,
      settings: settings ?? this.settings
    );
  }

  @override
  List<Object?> get props => [
    currentUser,
    userProfileState,
    userProfileError,
    selectedPaymentMethod,
    cvc,
    name,
    number,
    expireDate,
    settings
  ];
}

