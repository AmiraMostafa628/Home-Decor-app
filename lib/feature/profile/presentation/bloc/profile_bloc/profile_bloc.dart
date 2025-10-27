import 'dart:async';
import 'package:decor/core/resources/app_constants.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_event.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  static ProfileBloc get(context) => BlocProvider.of(context);
  ProfileBloc()
    : super(
        ProfileState(
          selectedPaymentMethod:
              AppConstants.paymentMethodItems.first.method, settings: AppConstants.notifications,
        ),
      ) {
    on<ChangePaymentMethodEvent>(_onChangePaymentMethod);
    on<ToggleSettingEvent>(_toggleSetting);
    on<UpdateCardHolderNameEvent>(_onUpdateCardHolderName);
    on<UpdateCardNumberEvent>(_onUpdateCardNumber);
    on<UpdateCardExpiryEvent>(_onUpdateCardExpiry);
    on<UpdateCardCvcEvent>(_onUpdateCardCvc);
  }

  FutureOr<void> _onChangePaymentMethod(
    ChangePaymentMethodEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(selectedPaymentMethod: event.selectedPaymentMethod));
  }


  FutureOr<void> _toggleSetting(event, Emitter<ProfileState> emit) {
    final updatedSettings = state.settings.map((setting) {
      if (setting.id == event.id) {
        return setting.copyWith(isEnabled: event.newValue);
      }
      return setting;
    }).toList();

    emit(state.copyWith(settings: updatedSettings));
  }

  FutureOr<void> _onUpdateCardHolderName(
    UpdateCardHolderNameEvent event,
    Emitter<ProfileState> emit,
  ) {

    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onUpdateCardNumber(
    UpdateCardNumberEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(name: event.number));
  }

  FutureOr<void> _onUpdateCardExpiry(
    UpdateCardExpiryEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(expireDate: event.expiry));
  }

  FutureOr<void> _onUpdateCardCvc(
    UpdateCardCvcEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(cvc: event.cvc));
  }
}
