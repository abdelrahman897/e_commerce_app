import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/app_bar/custom_app_bar.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_loading_state_widget.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_success_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class ProductScreen extends StatefulWidget {
  final String? categoryId;
  final String? brandId;
  const ProductScreen({super.key, required this.categoryId, this.brandId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = context.read<ProductBloc>();
    _productBloc.add(
      GetProductsEvent(
        params: widget.categoryId != null
            ? ProductParams(categoryId: widget.categoryId ,)
            : ProductParams(brandId: widget.brandId),
      ),
    );
  }

  void _loadMoreProduct(String nextPage, bool isMaxPaged) {
    if (isMaxPaged) return;
    _productBloc.add(
      GetProductsEvent(
        params: widget.categoryId != null
            ? ProductParams(categoryId: widget.categoryId , pageNumber: nextPage,)
            : ProductParams(brandId: widget.brandId , pageNumber: nextPage,),
        isLoadMore: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: BlocListener<CartBloc, CartState>(
          listener: (context, cartState) {
            switch (cartState) {
              case CartLoadingState():
                configLoading();
                EasyLoading.show(status: AppConstants.loading);
              case AddProductToCartSuccessState():
                EasyLoading.dismiss();
                SnackBarService.showSuccessMessage(
                  AppStrings.addToCartSuccessMessage,
                );
              case CartFailureState():
                EasyLoading.dismiss();
                SnackBarService.showErrorMessage(AppStrings.failureMessage);
              default:
                break;
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              switch (productState) {
                case ProductLoadingState():
                  return ProductLoadingStateWidget();
                case ProductsSuccessState():
                  return NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      if (notification is ScrollEndNotification) {
                        final pixels = notification.metrics.pixels;
                        final max = notification.metrics.maxScrollExtent;
                        const int triggerDistance = 200;
                        if (pixels >= max - triggerDistance) {
                          if (productState.isLoadingMore) return true;
                          _loadMoreProduct(
                            (productState.currentPage + 1).toString(),
                            productState.isMaxPaged,
                          );
                        }
                      }
                      return false;
                    },
                    child: ProductSuccessStateWidget(
                      products: productState.products,
                      isLoadingMore: productState.isLoadingMore,
                    ),
                  );
                case ProductFailureState():
                  return FailureStateWidget(
                    failureMessage: productState.failureMessage,
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
