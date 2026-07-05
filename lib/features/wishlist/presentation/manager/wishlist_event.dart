part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

final class GetWishlistEvent extends WishlistEvent {
  const GetWishlistEvent();
}

final class AddProductToWishlistEvent extends WishlistEvent {
  final WishlistParams wishlistParams;
  const AddProductToWishlistEvent({required this.wishlistParams});
  @override
  List<Object> get props => [wishlistParams];
}

final class DeleteProductFromWishlistEvent extends WishlistEvent {
  final WishlistParams wishlistParams;
  const DeleteProductFromWishlistEvent({required this.wishlistParams});
  @override
  List<Object> get props => [wishlistParams];
}
