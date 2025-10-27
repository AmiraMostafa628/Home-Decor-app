import 'package:decor/feature/home/domain/entities/slider_entity.dart';


class SliderModel extends SliderEntity {
  const SliderModel({
    required super.id,
    required super.image,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      image: json['image'],
    );
  }
}
