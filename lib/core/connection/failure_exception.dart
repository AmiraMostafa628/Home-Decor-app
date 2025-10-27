import 'package:decor/core/connection/failure.dart';

class FirebaseAuthCodeMapper {
  static Failure handleException(String code) {
    switch (code) {
      case 'user-not-found':
        return AuthFailure(message: 'No account found with this email.');
      case 'wrong-password':
        return AuthFailure(message: 'Incorrect password. Please try again.');
      case 'email-already-in-use':
        return AuthFailure(message: 'This email is already registered.');
      case 'invalid-email':
        return AuthFailure(message: 'The email address is not valid.');
      case 'weak-password':
        return AuthFailure(message: 'The password is too weak. Please choose a stronger one.');
      case 'too-many-requests':
        return AuthFailure(message: 'Too many attempts. Please try again later.');
      case 'operation-not-allowed':
        return AuthFailure(message: 'This operation is not allowed. Please contact support.');
      default:
        return ServerFailure(message: 'An unexpected error occurred. Please try again.');
    }
  }
}

