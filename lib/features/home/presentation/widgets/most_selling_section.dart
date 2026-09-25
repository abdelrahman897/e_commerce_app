import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_section_item.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/most_selling_body_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/most_selling_loading_widget.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MostSellingSection extends StatefulWidget {
  const MostSellingSection({super.key});

  @override
  State<MostSellingSection> createState() => _MostSellingSectionState();
}

class _MostSellingSectionState extends State<MostSellingSection> {
  bool _viewAllTapped = false;
  void _onViewAll() {
    setState(() => _viewAllTapped = true);
    context.read<ProductBloc>().add(
      GetProductsEvent(
        params: ProductParams(pageNumber: "2", soldParam: AppStrings.soldParam),
        isLoadMore: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, cartState) {
        switch (cartState) {
          case AddProductToCartSuccessState():
            SnackBarService.showSuccessMessage(
              AppStrings.addToCartSuccessMessage,
            );
          case CartFailureState():
            SnackBarService.showErrorMessage(AppStrings.failureMessage);
          default:
            break;
        }
      },
      child: CustomSectionItem(
        title: context.appLocalization.mostSelling,
        isTapped: _viewAllTapped,
        onPressed: _onViewAll,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            switch (productState) {
              case ProductLoadingState():
                return const MostSellingLoadingWidget();
              case ProductsSuccessState():
                return MostSellingBodySection(
                  products: productState.products,
                  isMaxPage: productState.isMaxPaged,
                  isLoadingMore: productState.isLoadingMore,
                );
              case ProductFailureState():
                return FailureStateWidget(
                  failureMessage: productState.failureMessage,
                  textStyle: context.textTheme.bodyMedium,
                );
              default:
                return const MostSellingLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
