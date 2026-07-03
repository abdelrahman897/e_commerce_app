import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget customLeadingWidget;
  final List<Widget> customActionsWidgets;
  const OnboardingAppBar({
    super.key,
    required this.customLeadingWidget,
    required this.customActionsWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: customLeadingWidget,
      leadingWidth: AppWidth.w100,
      actions: customActionsWidgets,
      actionsPadding: EdgeInsets.symmetric(horizontal: AppWidth.w8),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
