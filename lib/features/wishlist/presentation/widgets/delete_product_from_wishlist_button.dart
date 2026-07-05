import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class DeleteProductFromWishlistButton extends StatelessWidget {
  final VoidCallback? onDeleteTap;
  const DeleteProductFromWishlistButton({super.key, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onDeleteTap,
      child: Container(
        height: AppHeight.h30,
        width: AppWidth.w30,
        decoration: BoxDecoration(
          color: context.customColorScheme.container,
          shape: BoxShape.circle,
        ),
        child: Assets.icons.heartFilledIcn.svg(
          colorFilter: ColorFilter.mode(
            context.customColorScheme.button,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
