import 'package:e_commerce_app/core/storage_handler/local_storage_handler_interface.dart';
import 'package:hive_ce/hive_ce.dart';

class HiveStorageClient implements LocalStorageHandlerInterface {
  const HiveStorageClient();

  @override
  Future<void> clear({required String boxName}) async {
    final box = await _openBox(boxName);
    await box.clear();
  }

  @override
  Future<void> delete({required String boxName, required String key}) async {
    final box = await _openBox(boxName);
    await box.delete(key);
  }

  @override
  Future<T> get<T>({required String boxName, required String key}) async {
    final box = await _openBox(boxName);
    return box.get(key) as T;
  }

  @override
  Future<List<T>> getAll<T>({required String boxName}) async {
    final box = await _openBox(boxName);
    return box.values.cast<T>().toList();
  }

  @override
  Future<void> put({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    final box = await _openBox(boxName);
    await box.put(key, value);
  }

  Future<Box> _openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }
    return Hive.openBox(boxName);
  }

  @override
  Future<bool> containsKey({
    required String boxName,
    required String key,
  }) async {
    final box = await _openBox(boxName);
    return box.containsKey(key);
  }
}
