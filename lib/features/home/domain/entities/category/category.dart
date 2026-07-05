import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
  });

  factory Category.skeleton() {
    return Category(id: "1", name: "name", slug: "slug", imageUrl: "imageUrl");
  }

  @override
  List<Object?> get props {
    return [id, name, slug, imageUrl];
  }
}