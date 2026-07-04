import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/data/models/products_model.dart';

abstract interface class ProductDataSource {
  Future<ProductsModel> getProducts({required ProductParams params});
}
