import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uId;
  final String email;
  final String? userName;
  final String? mobileNumber;
  final String? photoUrl;
  final String? dateOfBirth;

  const UserEntity({
    required this.uId,
    required this.email,
    required this.userName,
    required this.mobileNumber,
    required this.photoUrl,
    required this.dateOfBirth,
  });

  static const empty = UserEntity(
    uId: '',
    email: '',
    userName: '',
    mobileNumber: '',
    photoUrl: '',
    dateOfBirth: '',
  );

  @override
  List<Object?> get props => [
    uId,
    email,
    userName,
    mobileNumber,
    photoUrl,
    dateOfBirth,
  ];
}
