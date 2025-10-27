import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;
  const Failure({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}
class AuthFailure extends Failure {
  const AuthFailure({required super.message});

  @override
  String toString() => message;
}


class ServerFailure extends Failure {

  const ServerFailure({
    required super.message,
  });

  @override
  String toString() => message;
}