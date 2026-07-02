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
        width: AppWidth.w32,
        height: AppHeight.h32,
        colorFilter: ColorFilter.mode(
          context.customColorScheme.button,
          BlendMode.srcIn,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppHeight.h60),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: AppHeight.h8,
            right: AppWidth.w8,
            left: AppWidth.w8,
          ),
          child: CustomBottomAppBar(heroTag: AppStrings.searchHeroTag),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppHeight.h110);
}
