import 'package:e_commerce_app/features/authentication/domain/entities/address_item_data.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String status;
  final String message;
  final List<AddressItemData> addresses;

  const Address({
    required this.status,
    required this.message,
    required this.addresses,
  });

  @override
  List<Object> get props => [status, message, addresses];
}
