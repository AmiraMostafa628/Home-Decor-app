import 'package:decor/feature/auth/data/models/login_model.dart';
import 'package:decor/feature/auth/domain/entities/login_entity.dart';

extension LoginEntityMapper on LoginEntity {
  LoginModel toModel() {
    return LoginModel(
      email: email,
      password: password,
    );
  }
}
