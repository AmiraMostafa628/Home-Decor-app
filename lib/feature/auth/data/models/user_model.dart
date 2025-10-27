import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String uId;

  @HiveField(3)
  final String mobileNumber;

  @HiveField(4)
  final String dateOfBirth;

  @HiveField(5)
  final String photoUrl;


  const UserModel({
    required this.uId,
    required this.email,
    required this.name,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      mobileNumber: json['mobileNumber'],
      dateOfBirth: json['dateOfBirth'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'mobileNumber': mobileNumber,
      'dateOfBirth': dateOfBirth,
      'photoUrl': photoUrl,
    };
  }


  UserEntity toEntity() => UserEntity(
    uId: uId,
    email: email,
    userName: name,
    mobileNumber: mobileNumber,
    dateOfBirth: dateOfBirth,
    photoUrl: photoUrl,

  );
}
