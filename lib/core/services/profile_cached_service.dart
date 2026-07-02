import 'package:e_commerce_app/core/errors/exceptions/cache_exception.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/storage_handler/local_storage_handler_interface.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address_item_data.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/profile.dart';

class ProfileCacheService {
  final LocalStorageHandlerInterface _localStorage;
  ProfileCacheService({required LocalStorageHandlerInterface localStorage})
    : _localStorage = localStorage;

  Future<Profile?> getCachedProfile() async {
    try {
      final hasProfile = await _localStorage.containsKey(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.name,
      );
      if (!hasProfile) return null;

      final name = await _localStorage.get<String>(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.name,
      );
      final email = await _localStorage.get<String>(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.email,
      );
      final phoneNumber = await _localStorage.get<String?>(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.phoneNumber,
      );

      AddressItemData? address;
      final hasAddress = await _localStorage.containsKey(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.address,
      );
      if (hasAddress) {
        final addrMap = await _localStorage.get<Map<String, dynamic>>(
          boxName: HiveBoxesConstant.profileBox,
          key: AppStorageKeys.address,
        );
        address = AddressItemData(
          id: addrMap['id'] as String,
          name: addrMap['name'] as String,
          details: addrMap['details'] as String,
          city: addrMap['city'] as String,
        );
      }

      return Profile(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveData({required Profile profile}) async {
    final raw = profile.toMap(profile);
    try {
      await _localStorage.put(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.email,
        value: raw[AppStorageKeys.email],
      );
      await _localStorage.put(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.name,
        value: raw[AppStorageKeys.name],
      );
      await _localStorage.put(
        boxName: HiveBoxesConstant.profileBox,
        key: AppStorageKeys.phoneNumber,
        value: raw[AppStorageKeys.phoneNumber],
      );
      final addressMap = raw[AppStorageKeys.address] as Map<String, dynamic>?;
      if (addressMap != null) {
        await _localStorage.put(
          boxName: HiveBoxesConstant.profileBox,
          key: AppStorageKeys.address,
          value: addressMap,
        );
      } else {
        final hasOldAddress = await _localStorage.containsKey(
          boxName: HiveBoxesConstant.profileBox,
          key: AppStorageKeys.address,
        );
        if (hasOldAddress) {
          await _localStorage.delete(
            boxName: HiveBoxesConstant.profileBox,
            key: AppStorageKeys.address,
          );
        }
      }
    } catch (error) {
      throw CacheWriteException(errorMessage: 'Cache Write operation failed');
    }
  }

  Future<void> clearField({required String key}) async {
    try {
      await _localStorage.delete(
        boxName: HiveBoxesConstant.profileBox,
        key: key,
      );
    } catch (error) {
      throw CacheWriteException(errorMessage: 'Cache Delete operation failed');
    }
  }

  Future<void> clearAll() async {
    try {
      await _localStorage.clear(boxName: HiveBoxesConstant.profileBox);
    } catch (error) {
      throw CacheWriteException(errorMessage: 'Cache Clear operation failed');
    }
  }
}
