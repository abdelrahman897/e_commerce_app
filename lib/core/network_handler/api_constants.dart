abstract final class ApiConstants {
  ApiConstants._();
  static const String baseUrl = "https://ecommerce.routemisr.com/api/v1/";

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 30);
}

abstract final class StripeApiConstants {
  StripeApiConstants._();
  static const String baseUrl = "https://api.stripe.com/v1/";
}

abstract final class StripeKeys {
  static const String clientSecret = "client_secret";
  static const String amount = "amount";
  static const String currency = 'currency';
}

abstract final class ApiKeys {
  ApiKeys._();
  static const String status = 'status';
  static const String message = "message";
  static const String noMessage = 'No message provided';
  static const String apiLogs = 'API Logs';
  static const String token = "token";
  static const String contentType = 'Content-Type';
  static const String name = "name";
  static const String email = "email";
  static const String role = "role";
  static const String user = "user";
  static const String password = "password";
  static const String tokenKey = "Authorization";
  static const String errors = 'errors';
  static const String errorMsg = 'msg';
  static const String errorParam = 'param';
  static const String rePassword = "rePassword";
  static const String phone = "phone";
  static const String resetCode = "resetCode";
  static const String newPassword = "newPassword";
  static const String statusMsg = "statusMsg";
  static const String metadata = "metadata";
  static const String data = "data";
  static const String results = "results";
  static const String id = "_id";
  static const String image = "image";
  static const String slug = "slug";
  static const String createdAt = "createdAt";
  static const String updatedAt = "updatedAt";
  static const String currentPage = "currentPage";
  static const String numberOfPages = "numberOfPages";
  static const String limit = "limit";
  static const String nextPage = "nextPage";
  static const String sold = "sold";
  static const String images = "images";
  static const String ratingsQuantity = "ratingsQuantity";
  static const String title = "title";
  static const String description = "description";
  static const String quantity = "quantity";
  static const String price = "price";
  static const String imageCover = "imageCover";
  static const String brand = "brand";
  static const String ratingsAverage = "ratingsAverage";
  static const String priceAfterDiscount = "priceAfterDiscount";
  static const String availableColors = "availableColors";
  static const String category = "category";
  static const String categoryParams = "category[in]";
  static const String count = "count";
  static const String product = "product";
  static const String cartOwner = "cartOwner";
  static const String products = "products";
  static const String totalCartPrice = "totalCartPrice";
  static const String v = "__v";
  static const String cartId = "cartId";
  static const String numOfCartItems = "numOfCartItems";
  static const String productId = "productId";
  static const String page = "page";
  static const String sort = "sort";
  static const String prevPage = "prevPage";
  static const String details = "details";
  static const String city = "city";
  static const String currentPassword = "currentPassword";
  static const String authorization = "Authorization";
}
