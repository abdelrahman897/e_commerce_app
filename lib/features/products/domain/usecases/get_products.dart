import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';

class GetProducts implements BaseUsecase<Products, ProductParams> {
  final ProductRepository _productRepository;
  const GetProducts(this._productRepository);
  @override
  Future<Either<Failure, Products>> call({
    required ProductParams params,
  }) async {
    return await _productRepository.getProducts(params: params);
  }
}
