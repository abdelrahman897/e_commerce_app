abstract interface class AuthInterfaceHandler {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
  Future<bool> isAuthenticated();
}
