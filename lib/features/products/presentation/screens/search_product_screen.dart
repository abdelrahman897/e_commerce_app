import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/state/empty_state_widget.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/core/widget/state/loading_more_state_widget.dart';
import 'package:e_commerce_app/core/widget/text_field/custom_text_field.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_loading_state_widget.dart';
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
  String _submittedQuery = '';
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const ResetProductsEvent());
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSubmitted(String value) {
    final query = value.trim();
    if (query.isEmpty) return;
    _submittedQuery = query;
    context.read<ProductBloc>().add(
      GetProductsEvent(params: ProductParams(categoryId: query)),
    );
  }

  void _loadMoreProduct(String nextPage, bool isMaxPaged) {
    if (isMaxPaged) return;
    context.read<ProductBloc>().add(
      GetProductsEvent(
        params: ProductParams(
          categoryId: _submittedQuery,
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
        child: Padding(
          padding: EdgeInsets.only(
            right: AppWidth.w12,
            left: AppWidth.w12,
            top: AppHeight.h16,
          ),
          child: Hero(
            tag: AppStrings.searchHeroTag,
            child: Material(
              color: Colors.transparent,              
              child: CustomTextField(
                hint: context.appLocalization.searchHint,
                controller: _searchController,
                customPrefixWidget: Assets.icons.searchIcn.svg(
                  colorFilter: ColorFilter.mode(
                    context.customColorScheme.button,
                    BlendMode.srcIn,
                  ),
                ),
                onSubmitted: _onSubmitted,
                focusNode: _searchFocusNode,
                textInputType: TextInputType.text,
                customSuffixWidget: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, _) => value.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                          },
                          icon: Icon(
                            Icons.close_outlined,
                            color: context.customColorScheme.text,
                          ),
                        ),
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, cartState) {
          switch (cartState) {
            case CartLoadingState():
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
        child: BlocConsumer<ProductBloc, ProductState>(
          listenWhen: (previous, current) =>
              (previous is ProductLoadingState) !=
              (current is ProductLoadingState),
          listener: (context, productState) {
            if (productState is ProductLoadingState) {
              EasyLoading.show(status: AppConstants.loading);
            } else {
              EasyLoading.dismiss();
            }
          },
          builder: (context, productState) {
            switch (productState) {
              case ProductLoadingState():
                return const ProductLoadingStateWidget();
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
                    addAutomaticKeepAlives: false,
                    itemBuilder: (context, index) {
                      if (index >= productState.products.length) {
                        return const LoadingMoreStateWidget();
                      }
                      final product = productState.products[index];
                      return ProductCard(
                        key: ValueKey<String>(product.id),
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
      ),
    );
  }
}
