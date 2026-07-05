import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
part 'brand_model.g.dart';

@HiveType(typeId: 2)
class BrandModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String slug;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final DateTime? createdAt;
  @HiveField(5)
  final DateTime? updatedAt;

  const BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json[ApiKeys.id] as String,
    name: json[ApiKeys.name] as String,
    slug: json[ApiKeys.slug] as String,
    imageUrl: json[ApiKeys.image] as String,
    createdAt: json[ApiKeys.createdAt] == null
        ? null
        : DateTime.parse(json[ApiKeys.createdAt] as String),
    updatedAt: json[ApiKeys.updatedAt] == null
        ? null
        : DateTime.parse(json[ApiKeys.updatedAt] as String),
  );

  Map<String, dynamic> toJson() => {
    ApiKeys.id: id,
    ApiKeys.name: name,
    ApiKeys.slug: slug,
    ApiKeys.image: imageUrl,
    ApiKeys.createdAt: createdAt?.toIso8601String(),
    ApiKeys.updatedAt: updatedAt?.toIso8601String(),
  };

  @override
  List<Object?> get props {
    return [id, name, slug, imageUrl, createdAt, updatedAt];
  }
}
