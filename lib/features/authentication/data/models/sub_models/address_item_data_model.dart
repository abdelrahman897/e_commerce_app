import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';

class AddressItemDataModel extends Equatable {
  final String id;
  final String name;
  final String details;
  final String phone;
  final String city;

  const AddressItemDataModel({
    required this.id,
    required this.name,
    required this.details,
    required this.phone,
    required this.city,
  });

  factory AddressItemDataModel.fromJson(Map<String, dynamic> json) =>
      AddressItemDataModel(
        id: json[ApiKeys.id] as String,
        name: json[ApiKeys.name] as String,
        details: json[ApiKeys.details] as String,
        phone: json[ApiKeys.phone] as String,
        city: json[ApiKeys.city] as String,
      );

  @override
  List<Object> get props => [id, name, details, phone, city];
}
