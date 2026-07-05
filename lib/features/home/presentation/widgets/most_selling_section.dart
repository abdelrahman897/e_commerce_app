import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_section_item.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/most_selling_body_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/most_selling_loading_widget.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MostSellingSection extends StatefulWidget {
  final bool onMostSellingTapViewAll;
  final VoidCallback? onMostSellingPressed;
  final ProductBloc productBloc;
  const MostSellingSection({
    super.key,
    required this.onMostSellingTapViewAll,
    this.onMostSellingPressed,
    required this.productBloc,
  });

  @override
  State<MostSellingSection> createState() => _MostSellingSectionState();
}

class _MostSellingSectionState extends State<MostSellingSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSectionItem(
      title: context.appLocalization.mostSelling,
      isTapped: widget.onMostSellingTapViewAll,
      onPressed: widget.onMostSellingPressed,
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
    );
  }
}
