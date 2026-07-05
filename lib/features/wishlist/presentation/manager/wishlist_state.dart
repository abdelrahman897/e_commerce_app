part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitialState extends WishlistState {
  const WishlistInitialState();
}

final class WishlistLoadingState extends WishlistState {
  const WishlistLoadingState();
}

final class WishlistEmptySuccessState extends WishlistState {
  const WishlistEmptySuccessState();
}

final class GetWishlistSuccessState extends WishlistState {
  const GetWishlistSuccessState();
}

final class AddProductToWishlistSuccessState extends WishlistState {
  const AddProductToWishlistSuccessState();
}

final class DeleteProductFromWishlistSuccessState extends WishlistState {
  const DeleteProductFromWishlistSuccessState();
}

final class WishlistFailureState extends WishlistState {
  final String failureMessage;
  const WishlistFailureState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}
