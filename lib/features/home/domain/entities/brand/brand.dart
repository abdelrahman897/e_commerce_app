import 'package:equatable/equatable.dart';
class Brand extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String imageUrl;

  const Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
  });

  factory Brand.skeleton() {
    return Brand(id: "1", name: "name", slug: "slug", imageUrl: "imageUrl");
  }
  @override
  List<Object?> get props {
    return [id, name, slug, imageUrl];
  }
}