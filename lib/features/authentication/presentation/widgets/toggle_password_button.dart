import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class TogglePasswordButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isPasswordHidden;
  const TogglePasswordButton({super.key, this.onTap, required this.isPasswordHidden});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: isPasswordHidden
          ? Assets.icons.slashEyeIcn.svg(color: context.customColorScheme.text)
          : Icon(
              Icons.remove_red_eye_outlined,
              color: context.customColorScheme.text,
            ),
    );
  }
}
