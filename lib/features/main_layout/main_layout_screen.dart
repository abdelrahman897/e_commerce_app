import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/app_bar/custom_app_bar.dart';
import 'package:e_commerce_app/core/widget/drawer/custom_drawer.dart';
import 'package:e_commerce_app/features/categories/screen/categories_tab_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_tab_screen.dart';
import 'package:e_commerce_app/features/authentication/presentation/screens/profile_tab_screen.dart';
import 'package:e_commerce_app/features/wishlist/presentation/screens/wishlist_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int currentIndex = 0;
  late final List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    tabs = [
      HomeTabScreen(),
      CategoriesTabScreen(),
      WishlistTabScreen(),
      ProfileTabScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(title: context.appLocalization.route),
        extendBody: false,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppWidth.w8, vertical: AppHeight.h12),
          child: tabs[currentIndex],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.r16),
            topRight: Radius.circular(AppRadius.r16),
          ),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.12,
            child: BottomNavigationBar(
              backgroundColor: context.customColorScheme.button,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              selectedItemColor: ColorManager.white,
              elevation: 0,
              showUnselectedLabels: false,
              showSelectedLabels: true,
              selectedLabelStyle: context.textTheme.labelSmall?.copyWith(
                color: ColorManager.white,
              ),
              unselectedLabelStyle: context.textTheme.labelSmall?.copyWith(
                color: ColorManager.white,
              ),
              onTap: _changeSelectedIndex,
              items: [
                CustomBottomNavBarItem(
                  title: context.appLocalization.home,
                  activeColor: context.customColorScheme.button,
                  iconPath: Assets.icons.homeIcn.path,
                ),
                CustomBottomNavBarItem(
                  title: context.appLocalization.category,
                  activeColor: context.customColorScheme.button,
                  iconPath: Assets.icons.categoryIcn.path,
                ),
                CustomBottomNavBarItem(
                  title: context.appLocalization.wishList,
                  activeColor: context.customColorScheme.button,
                  iconPath: Assets.icons.heartIcn.path,
                ),
                CustomBottomNavBarItem(
                  title: context.appLocalization.profile,
                  activeColor: context.customColorScheme.button,
                  iconPath: Assets.icons.userIcn.path,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeSelectedIndex(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
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
