part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {
  const HomeInitialState();
}

final class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

final class CategoriesSuccessState extends HomeState {
  const CategoriesSuccessState();
}

final class GetAllCategoriesSuccessState extends HomeState {
  final  List<Category> categories;
  const GetAllCategoriesSuccessState({required this.categories});
  @override
  List<Object> get props => [categories];
}

final class BrandsSuccessState extends HomeState {
  const BrandsSuccessState();
}

final class BrandsLoadMoreState extends HomeState {
  const BrandsLoadMoreState();
}

final class CategoriesLoadMoreState extends HomeState {
  const CategoriesLoadMoreState();
}

final class HomeFailureState extends HomeState {
  final String failureMessage;
  const HomeFailureState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}
