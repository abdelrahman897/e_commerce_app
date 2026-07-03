import 'package:equatable/equatable.dart';

class AddressItemData extends Equatable {
  final String id;
  final String name;
  final String details;
  final String city;

  const AddressItemData({
    required this.id,
    required this.name,
    required this.details,
    required this.city,
  });

  @override
  List<Object> get props => [id, name, details, city];
}
