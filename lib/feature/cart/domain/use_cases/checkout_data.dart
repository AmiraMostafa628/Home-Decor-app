import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CheckoutData  extends Equatable{
  final String name;
  final String address;
  final String phone;
  final  List<ProductEntity> items;
  final double total;

 const CheckoutData({
    required this.name,
    required this.address,
    required this.phone,
    required this.items,
    required this.total,
  });

  @override

  List<Object?> get props => [
    name,
    address,
    phone,
    items,
    total,
  ];
}


