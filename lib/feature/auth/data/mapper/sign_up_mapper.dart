import 'package:decor/feature/auth/data/models/sign_up_model.dart';
import 'package:decor/feature/auth/domain/entities/sign_up_entity.dart';

extension SignUpEntityMapper on SignUpEntity {
  SignUpModel toModel() {
    return SignUpModel(
      name: name,
      email: email,
      password: password,
      mobileNumber: mobileNumber,
      dateOfBirth: dateOfBirth,
      photoUrl: photoUrl,
    );
  }
}
