import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String mobileNumber;
  final String dateOfBirth;
  final String photoUrl;

  const SignUpEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.photoUrl
  });

  SignUpEntity copyWith({
    String? name,
    String? email,
    String? password,
    String? mobileNumber,
    String? dateOfBirth,
    String? photoUrl,
  }) {
    return SignUpEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }


  @override
  List<Object?> get props => [
    name,
    email,
    password,
    mobileNumber,
    dateOfBirth,
    photoUrl,
  ];
}