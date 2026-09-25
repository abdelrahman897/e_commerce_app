abstract interface class LocalStorageHandlerInterface {
  Future<void> put({
    required String boxName,
    required String key,
    required dynamic  value,
  });
  Future<void> putAll({
    required String boxName,
    required Map<String, dynamic> entries,
  });
  Future<T> get<T>({
    required String boxName,
    required String key,
  });
   Future<List<T>> getAll<T>({required String boxName}); 
  Future<void> delete({required String boxName, required String key});
  Future<void> clear({required String boxName});
   Future<bool> containsKey({
    required String boxName,
    required String key,
  });
}
