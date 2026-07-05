part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetCategoriesEvent extends HomeEvent {
  final CategoryParams params;

  const GetCategoriesEvent({required this.params});
  @override
  List<Object> get props => [params];
}

final class GetAllCategoriesEvent extends HomeEvent {
  const GetAllCategoriesEvent();
}

final class CategoriesLoadMoreEvent extends HomeEvent {
  final CategoryParams params;

  const CategoriesLoadMoreEvent({required this.params});
  @override
  List<Object> get props => [params];
}

final class BrandsLoadMoreEvent extends HomeEvent {
  final BrandParams params;

  const BrandsLoadMoreEvent({required this.params});
  @override
  List<Object> get props => [params];
}

final class GetBrandsEvent extends HomeEvent {
  final BrandParams params;

  const GetBrandsEvent({required this.params});
  @override
  List<Object> get props => [params];
}
