import 'package:e_commerce_app/features/authentication/data/mappers/address_item_data_mapper.dart';
import 'package:e_commerce_app/features/authentication/data/models/address_model.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';

extension AddressMapper on AddressModel {
  Address get toEntity => Address(
    status: status,
    message: message,
    addresses: addresses.map((item) => item.toEntity).toList(),
  );
}
