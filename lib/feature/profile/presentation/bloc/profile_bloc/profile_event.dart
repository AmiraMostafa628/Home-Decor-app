import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ChangePaymentMethodEvent extends ProfileEvent {
  final String selectedPaymentMethod;

  const ChangePaymentMethodEvent({required this.selectedPaymentMethod});

  @override
  List<Object?> get props => [selectedPaymentMethod];
}

class ToggleSettingEvent extends ProfileEvent {
  final String id;
  final bool newValue;

  const ToggleSettingEvent({required this.id, required this.newValue});

  @override
  List<Object> get props => [id, newValue];
}

class UpdateCardHolderNameEvent extends ProfileEvent {
  final String name;

  const UpdateCardHolderNameEvent(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateCardNumberEvent extends ProfileEvent {
  final String number;

  const UpdateCardNumberEvent(this.number);

  @override
  List<Object> get props => [number];
}

class UpdateCardExpiryEvent extends ProfileEvent {
  final String expiry;

  const UpdateCardExpiryEvent(this.expiry);

  @override
  List<Object> get props => [expiry];
}

class UpdateCardCvcEvent extends ProfileEvent {
  final String cvc;

  const UpdateCardCvcEvent(this.cvc);

  @override
  List<Object> get props => [cvc];
}
