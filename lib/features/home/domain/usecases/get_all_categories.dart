import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/usecases/base_usecase_without_params.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';

class GetAllCategories implements BaseUsecaseWithoutParams<List<Category>> {
  final HomeRepository _homeRepository;
  const GetAllCategories({required HomeRepository homeRepository})
    : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, List<Category>>> call() async {
    return await _homeRepository.getAllCategories();
  }
}
