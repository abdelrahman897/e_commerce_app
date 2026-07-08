import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:equatable/equatable.dart';

class SubCategory extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String imageUrl;
  const SubCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
  });

  factory SubCategory.skeleton() {
    return SubCategory(
      id: "1",
      name: "name",
      slug: "slug",
      imageUrl: Assets.images.categoryImg.path,
    );
  }

  static final List<SubCategory> subCategoryList = List.generate(
    9,
    (_) => SubCategory.skeleton(),
  );

  @override
  List<Object> get props => [id, name, slug, imageUrl];
}
