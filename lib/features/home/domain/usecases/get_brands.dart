import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';

class GetBrands implements BaseUsecase<List<Brand>, BrandParams> {
  final HomeRepository _homeRepository;
  const GetBrands({required HomeRepository homeRepository})
    : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, List<Brand>>> call({
    required BrandParams params,
  }) async {
    return await _homeRepository.getBrands(params: params);
  }
}
