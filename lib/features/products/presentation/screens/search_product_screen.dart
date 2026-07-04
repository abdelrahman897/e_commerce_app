import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
import 'package:e_commerce_app/core/widget/state/empty_state_widget.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/core/widget/state/loading_more_state_widget.dart';
import 'package:e_commerce_app/core/widget/text_field/custom_text_field.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    configLoading();
    context.read<ProductBloc>().add(const ResetProductsEvent());
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _loadMoreProduct(String nextPage, bool isMaxPaged) {
    if (isMaxPaged) return;
    context.read<ProductBloc>().add(
      GetProductsEvent(
        params: ProductParams(
          categoryId: _searchController.text,
          pageNumber: nextPage,
        ),
        isLoadMore: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Hero(
          tag: AppStrings.searchHeroTag,
          child: Material(
            child: CustomTextField(
              hint: context.appLocalization.searchHint,
              controller: _searchController,
              customPrefixWidget: Assets.icons.searchIcn.svg(
                colorFilter: ColorFilter.mode(
                  context.customColorScheme.button,
                  BlendMode.srcIn,
                ),
              ),
              onSubmitted: (value) {
                context.read<ProductBloc>().add(
                  GetProductsEvent(params: ProductParams(categoryId: value)),
                );
              },
              focusNode: _searchFocusNode,
              textInputType: TextInputType.text,
              customSuffixWidget: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                      },
                      icon: Icon(
                        Icons.close_outlined,
                        color: context.customColorScheme.text,
                      ),
                    )
                  : null,
              maxLines: 1,
            ),
          ),
        ),
      ),
      body: 
      // BlocListener<CartBloc, CartState>(
      //   listener: (context, cartState) {
      //     switch (cartState) {
      //       case CartLoadingState():
      //         configLoading();
      //         EasyLoading.show(status: AppConstants.loading);
      //       case AddProductToCartSuccessState():
      //         EasyLoading.dismiss();
      //         SnackBarService.showSuccessMessage(
      //           AppStrings.addToCartSuccessMessage,
      //         );
      //       case CartFailureState():
      //         EasyLoading.dismiss();
      //         SnackBarService.showErrorMessage(AppStrings.failureMessage);
      //       default:
      //         break;
      //     }
      //   },
         BlocConsumer<ProductBloc, ProductState>(
          listener: (context, productState) {
            if (productState is ProductLoadingState) {
              EasyLoading.show(status: AppConstants.loading);
            } else {
              EasyLoading.dismiss();
            }
          },
          builder: (context, productState) {
            switch (productState) {
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
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppWidth.w8,
                      mainAxisSpacing: AppHeight.h8,
                      childAspectRatio: 7 / 9,
                    ),
                    itemBuilder: (context, index) {
                      if (index >= productState.products.length) {
                        return const LoadingMoreStateWidget();
                      }
                      final product = productState.products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.productDetailsRoute,
                          arguments: product,
                        ),
                      );
                    },
                    itemCount: productState.isMaxPaged
                        ? productState.products.length
                        : productState.products.length + 1,
                  ),
                );
              case ProductFailureState():
                return FailureStateWidget(
                  failureMessage: productState.failureMessage,
                );
              default:
                return EmptyStateWidget();
            }
          },
        ),
    );
  }
}
