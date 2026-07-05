import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/brand_body_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/brand_loading_widget.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandsSection extends StatelessWidget {
  final HomeBloc homeBloc;
  final bool onBrandTapViewAll;
  final VoidCallback? onBrandPressed;
  const BrandsSection({
    super.key,
    required this.homeBloc,
    required this.onBrandTapViewAll,
    this.onBrandPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSectionItem(
      isTapped: onBrandTapViewAll,
      title: context.appLocalization.brands,
      onPressed: onBrandPressed,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, categoryState) {
          switch (categoryState) {
            case HomeLoadingState():
              return BrandLoadingWidget();
            case BrandsLoadMoreState():
              return BrandBodySection(
                brands: homeBloc.brands,
                isMaxPage: false,
              );
            case BrandsSuccessState():
              return BrandBodySection(
                brands: homeBloc.brands,
                isMaxPage: homeBloc.isMaxPageBrand,
              );
            case HomeFailureState():
              return FailureStateWidget(
                onTap: (){},
                failureMessage: categoryState.failureMessage,
                textStyle: context.textTheme.bodyMedium,
              );
            default:
              return homeBloc.brands.isNotEmpty
                  ? BrandBodySection(
                      brands: homeBloc.brands,
                      isMaxPage: homeBloc.isMaxPageBrand,
                    )
                  : const BrandLoadingWidget();
          }
        },
      ),
    );
  }
}
