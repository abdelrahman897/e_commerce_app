import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/main_layout/main_layout_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.tabs,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<MainLayoutTab> tabs;

  static const double _heightFactor = 0.086;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColorScheme;
    final l10n = context.appLocalization;
    final labelStyle = context.textTheme.labelSmall?.copyWith(
      color: ColorManager.white,
    );

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.r20),
      ),
      child: SizedBox(
        height: context.height * _heightFactor,
        child: BottomNavigationBar(
          backgroundColor: colors.button,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: ColorManager.white,
          elevation: 0,
          showUnselectedLabels: false,
          selectedLabelStyle: labelStyle,
          unselectedLabelStyle: labelStyle,
          items: [
            for (final tab in tabs)
              CustomBottomNavBarItem(
                title: tab.label(l10n),
                iconPath: tab.iconPath,
                activeColor: colors.button,
              ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  CustomBottomNavBarItem({
    required String title,
    required String iconPath,
    required Color activeColor,
  }) : super(
         label: title,
         activeIcon: CircleAvatar(
           radius: AppRadius.r16,
           backgroundColor: ColorManager.white,
           child: SvgPicture.asset(
             iconPath,
             width: AppWidth.w18,
             height: AppHeight.h18,
             colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
           ),
         ),
         icon: SvgPicture.asset(
           iconPath,
           width: AppWidth.w22,
           height: AppHeight.h22,
           colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
         ),
       );
}
