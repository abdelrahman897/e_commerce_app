import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

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
    return Bounceable(
      onTap: () {
        setState(() => isFavourite = !isFavourite);
        widget.onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.customColorScheme.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(80),
              spreadRadius: AppRadius.r2,
              blurRadius: AppRadius.r4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isFavourite
            ? Assets.icons.heartFilledIcn.svg(
                color: context.customColorScheme.button,
              )
            : Assets.icons.heartIcn.svg(
                colorFilter: ColorFilter.mode(
                  context.customColorScheme.button,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}
