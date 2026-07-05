import 'package:e_commerce_app/features/home/data/models/brands_response/brand_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';

extension BrandMapper on BrandModel {
  Brand get toEntity =>
      Brand(id: id, name: name, slug: slug, imageUrl: imageUrl);
}
