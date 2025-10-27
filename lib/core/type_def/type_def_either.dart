import 'package:dartz/dartz.dart';
import 'package:decor/core/connection/failure.dart';


typedef FutureFailure<T> =  Future<Either<Failure,T>>;