import 'package:e_commerce_app/core/resources/constants_manager.dart';

sealed class CacheException implements Exception {
  final String errorMessage;
  const CacheException({required this.errorMessage});
}

final class CacheNotFoundException extends CacheException {
  const CacheNotFoundException()
    : super(errorMessage: AppErrorMessages.cacheNotFound);
}

final class CacheReadException extends CacheException {
  const CacheReadException({required super.errorMessage});
}

final class CacheWriteException extends CacheException {
  const CacheWriteException({required super.errorMessage});
}

final class UnknownCacheException extends CacheException {
  const UnknownCacheException({required super.errorMessage});
}
