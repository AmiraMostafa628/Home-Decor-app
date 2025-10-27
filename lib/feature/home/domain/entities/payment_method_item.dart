import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PaymentMethodItem extends Equatable{
  final IconData icon;
  final String method;

  const PaymentMethodItem({
    required this.icon,
    required this.method,

  });

  @override
  List<Object?> get props => [icon,method];
}