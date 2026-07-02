import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';

// T => Type
abstract interface class BaseUsecase<Output, Input> {
  Future<Either<Failure, Output>> call({required Input params});
}
