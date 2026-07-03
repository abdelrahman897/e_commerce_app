import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String userGmail;
  const HeaderSection({super.key, required this.userGmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.appLocalization.titleWelcome,
          style: context.textTheme.bodyMedium,
        ),
        Text(userGmail, style: context.textTheme.titleMedium),
      ],
    );
  }
}
