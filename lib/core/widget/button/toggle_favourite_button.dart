import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ToggleFavouriteButton extends StatefulWidget {
  final VoidCallback? onTap;
  const ToggleFavouriteButton({super.key, this.onTap});

  @override
  State<ToggleFavouriteButton> createState() => _ToggleFavouriteButtonState();
}

class _ToggleFavouriteButtonState extends State<ToggleFavouriteButton> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h32,
                width: AppWidth.w32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      spreadRadius: AppRadius.r2,
                      blurRadius: AppRadius.r4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: context.customColorScheme.primary,
                ),
      child: IconButton(
         padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed:  () {
          setState(() => isFavourite = !isFavourite);
          widget.onTap?.call();
        }, icon: isFavourite
              ? Assets.icons.heartFilledIcn.svg(
                  width: AppWidth.w22,
                  height: AppHeight.h22,
                  color: context.customColorScheme.button,
                )
              : Assets.icons.heartIcn.svg(
                  width: AppWidth.w22,
                  height: AppHeight.h22,
                  colorFilter: ColorFilter.mode(
                    context.customColorScheme.button,
                    BlendMode.srcIn,
                  ),
                ),),
    );
  }
}
