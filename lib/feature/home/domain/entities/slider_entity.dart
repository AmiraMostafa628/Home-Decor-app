import 'package:equatable/equatable.dart';


class SliderEntity extends Equatable {
  final int id;
  final String image;

  const SliderEntity({
    required this.id,
    required this.image,
  });

  @override
  List<Object?> get props => [
    id,
    image,
  ];
}