import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:flutter/material.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBounceableButton(
      height: AppHeight.h45,
      borderRadius: AppRadius.r25,
      onTap: () => Navigator.pushNamed(context, Routes.searchProductRoute),
      backgroundColor: context.customColorScheme.container,
      borderColor: context.customColorScheme.button,
      customChildWidget: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: AppWidth.w8,
        children: [
          Assets.icons.searchIcn.svg(
            colorFilter: ColorFilter.mode(
              context.customColorScheme.button,
              BlendMode.srcIn,
            ),
          ),
          Text(
            context.appLocalization.searchHint,
            style: context.textTheme.titleSmall,
          ),
        ],
      ).setHorizontalPaddingOnWidget(AppWidth.w8),
    );
  }
}
