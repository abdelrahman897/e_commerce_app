import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/widget/app_bar/sub_widget/search_bar_container.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final String heroTag;
  const CustomBottomAppBar({super.key, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Hero(tag: heroTag, child: SearchBarContainer()),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.cartRoute);
          },
          icon: Assets.icons.shoppingCartIcn.svg(
            colorFilter: ColorFilter.mode(
              context.customColorScheme.button,
              BlendMode.srcIn,
            ),
            width: AppWidth.w30,
        height: AppHeight.h30,
          ),

        ),
      ],
    );
  }
}
