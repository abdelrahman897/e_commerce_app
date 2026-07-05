import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';

class GetCategories implements BaseUsecase<List<Category>, CategoryParams> {
  final HomeRepository _homeRepository;
  const GetCategories({required HomeRepository homeRepository})
    : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, List<Category>>> call({
    required CategoryParams params,
  }) async {
    return await _homeRepository.getCategories(params: params);
  }
}
