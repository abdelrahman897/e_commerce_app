import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const ProductAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: context.customColorScheme.button,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.searchProductRoute);
          },
          icon: Assets.icons.searchIcn.svg(
            width: AppWidth.w32,
        height: AppHeight.h32,
        colorFilter: ColorFilter.mode(
          context.customColorScheme.button,
          BlendMode.srcIn,
        ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.cartRoute);
          },
          icon: Assets.icons.shoppingCartIcn.svg(
            width: AppWidth.w32,
        height: AppHeight.h32,
        colorFilter: ColorFilter.mode(
          context.customColorScheme.button,
          BlendMode.srcIn,
        ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppHeight.h60);
}
