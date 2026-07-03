import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class ToggleRigsterPasswordButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isPassword;
  final bool isPasswordHidden;
  final bool isRePasswordHidden;
  final bool isRePassword;
  const ToggleRigsterPasswordButton({
    super.key,
    this.isPassword = false,
    this.isRePassword = false,
    required this.isPasswordHidden,
    required this.isRePasswordHidden, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      // onTap: () {
      //   if (isPassword) {
      //     isPasswordHidden = !isPasswordHidden;
      //   } else {
      //     isRePasswordHidden = !isRePasswordHidden;
      //   }
      //   setState(() {});
      // },
      child: (isPassword ? isPasswordHidden : isRePasswordHidden)
          ? Assets.icons.slashEyeIcn.svg(color: context.customColorScheme.text)
          : Icon(
              Icons.remove_red_eye_rounded,
              color: context.customColorScheme.text,
            ),
    );
  }
}
