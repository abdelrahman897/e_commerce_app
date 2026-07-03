import 'package:e_commerce_app/features/authentication/data/models/sub_models/address_item_data_model.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address_item_data.dart';

extension AddressItemDataMapper on AddressItemDataModel {
  AddressItemData get toEntity =>
      AddressItemData(id: id, name: name, details: details, city: city);
}
