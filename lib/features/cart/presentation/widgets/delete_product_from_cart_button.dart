import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class DeleteProductFromCartButton extends StatelessWidget {
  final VoidCallback? onDeleteTap;
  const DeleteProductFromCartButton({super.key, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onDeleteTap,
      child: Container(
        height: AppHeight.h24,
        width: AppWidth.w24,
        decoration: BoxDecoration(
          color: context.customColorScheme.container,
          shape: BoxShape.circle,
        ),
        child: Assets.icons.deleteIcn.svg(
          colorFilter: ColorFilter.mode(
            context.customColorScheme.button,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
