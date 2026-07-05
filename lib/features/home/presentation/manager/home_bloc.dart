import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_all_categories.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_brands.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_categories.dart';
import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBrands _getBrands;
  final GetCategories _getCategories;
  final GetAllCategories _getAllCategories;
  List<Category> categories = [];
  List<Brand> brands = [];
  bool isMaxPageCategory = false;
  bool isMaxPageBrand = false;
  int currentBrandPage = 1;
  int currentCategoryPage = 1;
  HomeBloc({
    required GetBrands getBrands,
    required GetCategories getCategories,
    required GetAllCategories getAllCategories,
  }) : _getAllCategories = getAllCategories,
       _getBrands = getBrands,
       _getCategories = getCategories,
       super(const HomeInitialState()) {
    on<GetCategoriesEvent>(_onGetCategoriesEvent);
    on<GetBrandsEvent>(_onGetBrandsEvent);
    on<CategoriesLoadMoreEvent>(_onCategoriesLoadMoreEvent);
    on<GetAllCategoriesEvent>(_onGetAllCategoriesEvent);
    on<BrandsLoadMoreEvent>(_onBrandsLoadMoreEvent);
  }

  FutureOr<void> _onGetCategoriesEvent(
    GetCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    final result = await _getCategories(params: event.params);
    result.fold(
      (failure) => emit(HomeFailureState(failureMessage: failure.message)),
      (categories) {
        this.categories = categories;
        isMaxPageCategory = false;
        currentCategoryPage = 1;
        emit(CategoriesSuccessState());
      },
    );
  }

  FutureOr<void> _onGetAllCategoriesEvent(
    GetAllCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    final result = await _getAllCategories();
    result.fold(
      (failure) => emit(HomeFailureState(failureMessage: failure.message)),
      (categories) {
        emit(GetAllCategoriesSuccessState(categories: categories));
      },
    );
  }

  FutureOr<void> _onGetBrandsEvent(
    GetBrandsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    final result = await _getBrands(params: event.params);
    result.fold(
      (failure) => emit(HomeFailureState(failureMessage: failure.message)),
      (brands) {
        this.brands = brands;
        isMaxPageBrand = false;
        currentBrandPage = 1;
        emit(BrandsSuccessState());
      },
    );
  }

  FutureOr<void> _onBrandsLoadMoreEvent(
    BrandsLoadMoreEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (isMaxPageBrand) return;
    emit(BrandsLoadMoreState());
    final result = await _getBrands(params: event.params);
    result.fold(
      (failure) => emit(HomeFailureState(failureMessage: failure.message)),
      (brands) {
        this.brands.addAll(brands);
        isMaxPageBrand = true;
        currentBrandPage = 2;
        emit(BrandsSuccessState());
      },
    );
  }

  FutureOr<void> _onCategoriesLoadMoreEvent(
    CategoriesLoadMoreEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (isMaxPageCategory) return;
    emit(CategoriesLoadMoreState());
    final result = await _getCategories(params: event.params);
    result.fold(
      (failure) => emit(HomeFailureState(failureMessage: failure.message)),
      (categories) {
        this.categories.addAll(categories);
        isMaxPageCategory = true;
        currentCategoryPage = 2;
        emit(CategoriesSuccessState());
      },
    );
  }
}
