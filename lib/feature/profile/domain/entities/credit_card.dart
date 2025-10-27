import 'package:equatable/equatable.dart';

class CreditCard extends Equatable {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvc;

  const CreditCard({
    this.cardHolderName = '',
    this.cardNumber = '',
    this.expiryDate = '',
    this.cvc = '',
  });

  CreditCard copyWith({
    String? cardHolderName,
    String? cardNumber,
    String? expiryDate,
    String? cvc,
  }) {
    return CreditCard(
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvc: cvc ?? this.cvc,
    );
  }

  @override
  List<Object?> get props => [cardHolderName, cardNumber, expiryDate, cvc];
}
