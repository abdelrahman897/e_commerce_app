import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';

import 'sub_models/address_item_data_model.dart';

class AddressModel extends Equatable {
  final String status;
  final String message;
  final List<AddressItemDataModel> addresses;

  const AddressModel({
    required this.status,
    required this.message,
    required this.addresses,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      status: json[ApiKeys.status] as String,
      message: json[ApiKeys.message] as String,
      addresses: (json[ApiKeys.data] as List<dynamic>)
          .map((e) => AddressItemDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object> get props => [status, message, addresses];
}
