import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';

abstract interface class BaseUsecaseWithoutParams<Output> {
  Future<Either<Failure, Output>> call();
}
