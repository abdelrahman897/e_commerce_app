import 'package:e_commerce_app/core/errors/exceptions/cache_exception.dart';
import 'package:e_commerce_app/core/handler/authentication_handler/auth_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthHandlerSecureStorage implements AuthInterfaceHandler {
  AuthHandlerSecureStorage({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;
  final FlutterSecureStorage _secureStorage;
  String? _cachedToken;
  @override
  Future<void> clearToken() async {
    _cachedToken = null;
    try {
      await _secureStorage.delete(key: ApiKeys.tokenKey);
    } on PlatformException catch (error) {
      throw CacheWriteException(
        errorMessage: error.message ?? AppErrorMessages.cacheClearError,
      );
    } catch (_) {
      throw const UnknownCacheException(
        errorMessage: AppErrorMessages.cacheClearUnexpectedError,
      );
    }
  }

  @override
  Future<String?> getToken() async {
    if (_cachedToken != null) {
      return _cachedToken;
    }
    try {
      _cachedToken = await _secureStorage.read(key: ApiKeys.tokenKey);
      return _cachedToken;
    } on PlatformException catch (error) {
      _cachedToken = null;
      throw CacheReadException(
        errorMessage: error.message ?? AppErrorMessages.cacheReadedError,
      );
    } catch (_) {
      _cachedToken = null;
      throw UnknownCacheException(
        errorMessage: AppErrorMessages.cacheUnexpectedReadError,
      );
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }

  @override
  Future<void> saveToken(String token) async {
    _cachedToken = token;
    try {
      await _secureStorage.write(key: ApiKeys.tokenKey, value: token);
    } on PlatformException catch (error) {
      _cachedToken = null;
      throw CacheWriteException(
        errorMessage: error.message ?? AppErrorMessages.cacheSavedError,
      );
    } catch (_) {
      _cachedToken = null;
      throw UnknownCacheException(
        errorMessage: AppErrorMessages.cacheUnexpectedSaveError,
      );
    }
  }
}
