import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
  const CacheFailure.notFound()
    : super(message: AppErrorMessages.cacheNotFound);

  const CacheFailure.readError()
    : super(message: AppErrorMessages.cacheReadError);

  const CacheFailure.writeError()
    : super(message: AppErrorMessages.cacheWriteError);

  const CacheFailure.unknown() : super(message: AppErrorMessages.unknown);

  @override
  List<Object?> get props => [message];
}
