import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_body_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_loading_widget.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/custom_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSection extends StatelessWidget {
  final HomeBloc homeBloc;
  final bool onCategoryTapViewAll;
  final VoidCallback? onCategoryPressed;
  const CategoriesSection({
    super.key,
    required this.homeBloc,
    required this.onCategoryTapViewAll,
    this.onCategoryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSectionItem(
      isTapped: onCategoryTapViewAll,
      title: context.appLocalization.categories,
      onPressed: onCategoryPressed,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, categoryState) {
          switch (categoryState) {
            case HomeLoadingState():
              return CategoryLoadingWidget();
            case CategoriesSuccessState():
              return CategoryBodySection(
                categories: homeBloc.categories,
                isMaxPage: homeBloc.isMaxPageCategory,
              );
            case CategoriesLoadMoreState():
              return CategoryBodySection(
                categories: homeBloc.categories,
                isMaxPage: false,
              );
            case HomeFailureState():
              return FailureStateWidget(
                onTap: () {},
                failureMessage: categoryState.failureMessage,
                textStyle: context.textTheme.bodyMedium,
              );
            default:
              return homeBloc.categories.isNotEmpty
                  ? CategoryBodySection(
                      categories: homeBloc.categories,
                      isMaxPage: homeBloc.isMaxPageCategory,
                    )
                  : const CategoryLoadingWidget();
          }
        },
      ),
    );
  }
}
