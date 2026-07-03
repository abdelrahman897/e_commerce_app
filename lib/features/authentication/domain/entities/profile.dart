import 'package:e_commerce_app/features/authentication/domain/entities/address_item_data.dart';
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String name;
  final String email;
  final String? phoneNumber;
  final AddressItemData? address;

  const Profile({
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
  });

  Profile copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    AddressItemData? address,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap(Profile p) => {
    'name': p.name,
    'email': p.email,
    'phoneNumber': p.phoneNumber,
    'address': p.address == null
        ? null
        : {
            'id': p.address!.id,
            'name': p.address!.name,
            'details': p.address!.details,
            'city': p.address!.city,
          },
  };

  factory Profile.fromMap(Map<String, dynamic> m) {
    AddressItemData? address;
    final addrRaw = m['address'];
    if (addrRaw != null) {
      final a = Map<String, dynamic>.from(addrRaw as Map);
      address = AddressItemData(
        id: a['id'] as String,
        name: a['name'] as String,
        details: a['details'] as String,
        city: a['city'] as String,
      );
    }
    return Profile(
      name: m['name'] as String? ?? '',
      email: m['email'] as String? ?? '',
      phoneNumber: m['phoneNumber'] as String?,
      address: address,
    );
  }

  @override
  List<Object?> get props => [name, email, phoneNumber, address];
}