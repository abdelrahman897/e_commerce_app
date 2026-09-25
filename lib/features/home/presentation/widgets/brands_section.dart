import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/brand_body_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/brand_loading_widget.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandsSection extends StatefulWidget {
  const BrandsSection({super.key});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection> {
  bool _viewAllTapped = false;

  void _onViewAll() {
    final bloc = context.read<HomeBloc>();
    setState(() => _viewAllTapped = true); // بيبني الـ section ده بس
    bloc.add(
      BrandsLoadMoreEvent(
        params: BrandParams(pageNumber: (bloc.currentBrandPage + 1).toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return CustomSectionItem(
      isTapped: _viewAllTapped,
      title: context.appLocalization.brands,
      onPressed: _onViewAll,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, brandState) {
          switch (brandState) {
            case HomeLoadingState():
              return const BrandLoadingWidget();
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
                onTap: () {},
                failureMessage: brandState.failureMessage,
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
