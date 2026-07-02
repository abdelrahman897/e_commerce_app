import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

class SignInParams {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    return {ApiKeys.email: email, ApiKeys.password: password};
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.password: password,
      ApiKeys.rePassword: rePassword,
      ApiKeys.phone: phone,
    };
  }
}

class ForgetPasswordParams {
  final String email;

  const ForgetPasswordParams({required this.email});
  Map<String, dynamic> toJson() {
    return {ApiKeys.email: email};
  }
}

class ResetPasswordParams {
  final String email;
  final String newPassword;

  const ResetPasswordParams({required this.email, required this.newPassword});
  Map<String, dynamic> toJson() {
    return {ApiKeys.email: email, ApiKeys.newPassword: newPassword};
  }
}

class ResetCodeParams {
  final String resetCode;

  const ResetCodeParams({required this.resetCode});
  Map<String, dynamic> toJson() {
    return {ApiKeys.resetCode: resetCode};
  }
}

class ProductParams {
  final String? categoryId;
  final String? brandId;
  final String limit;
  final String pageNumber;
  final String? soldParam;

  const ProductParams({
    this.categoryId,
    this.brandId,
    this.limit = AppConstants.defaultLimit,
    this.pageNumber = AppConstants.firstPage,
    this.soldParam,
  });

  Map<String, dynamic> paginationToJson() {
    return (brandId != null)
        ? {
            ApiKeys.brand: brandId,
            ApiKeys.limit: limit,
            ApiKeys.page: pageNumber,
          }
        : {
            ApiKeys.categoryParams: categoryId,
            ApiKeys.limit: limit,
            ApiKeys.page: pageNumber,
          };
  }

  Map<String, dynamic> soldToJson() {
    return {
      ApiKeys.sort: soldParam,
      ApiKeys.limit: limit,
      ApiKeys.page: pageNumber,
    };
  }
}

class CartParams {
  final String cartProductId;
  final int? quantity;
  const CartParams({required this.cartProductId, this.quantity});
  Map<String, dynamic> toJson() {
    return (quantity != null)
        ? {ApiKeys.count: quantity}
        : {ApiKeys.productId: cartProductId};
  }
}

class WishlistParams {
  final String productId;
  const WishlistParams({required this.productId});
  Map<String, dynamic> toJson() {
    return {ApiKeys.productId: productId};
  }
}

class CategoryParams {
  final String limit;
  final String pageNumber;
  CategoryParams({
    this.limit = AppConstants.defaultCategoryLimit,
    this.pageNumber = AppConstants.firstPage,
  });
  Map<String, dynamic> toJson() {
    return {ApiKeys.limit: limit, ApiKeys.page: pageNumber};
  }
}

class BrandParams {
  final String limit;
  final String pageNumber;
  BrandParams({
    this.limit = AppConstants.defaultBrandLimit,
    this.pageNumber = AppConstants.firstPage,
  });
  Map<String, dynamic> toJson() {
    return {ApiKeys.limit: limit, ApiKeys.page: pageNumber};
  }
}

class UserUpdateDataParams {
  final String name;
  final String email;
  final String phone;
  const UserUpdateDataParams({
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.phone: phone,
    };
  }
}

class UserUpdatePasswordParams {
  final String currentPassword;
  final String password;
  final String rePassword;
  const UserUpdatePasswordParams({
    required this.currentPassword,
    required this.password,
    required this.rePassword,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKeys.currentPassword: currentPassword,
      ApiKeys.password: password,
      ApiKeys.rePassword: rePassword,
    };
  }
}

class AddressParams {
  final String? userId;
  final String? name;
  final String? details;
  final String? phone;
  final String? city;

  const AddressParams({
    this.userId,
    this.name,
    this.details,
    this.phone,
    this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.details: details,
      ApiKeys.phone: phone,
      ApiKeys.city: city,
    };
  }
}

class PaymentParams {
  final int amount;
  final String currency;
  const PaymentParams({required this.amount, required this.currency});

  Map<String, dynamic> toFormData() {
    return {StripeKeys.amount: amount * 100, StripeKeys.currency: currency};
  }
}
