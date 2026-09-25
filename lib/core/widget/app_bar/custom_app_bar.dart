import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/app_bar/sub_widget/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Assets.icons.splashLogo.svg(
        width: AppWidth.w36,
        height: AppHeight.h36,
        colorFilter: ColorFilter.mode(
          context.customColorScheme.button,
          BlendMode.srcIn,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppHeight.h60),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: AppHeight.h4,
            right: AppWidth.w16,
            left: AppWidth.w16,
          ),
          child: CustomBottomAppBar(heroTag: AppStrings.searchHeroTag),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppHeight.h110);
}
