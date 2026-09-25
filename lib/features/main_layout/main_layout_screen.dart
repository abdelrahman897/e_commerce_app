import 'dart:async';

import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/services/notification_permission_service.dart';
import 'package:e_commerce_app/core/widget/app_bar/custom_app_bar.dart';
import 'package:e_commerce_app/core/widget/drawer/custom_drawer.dart';
import 'package:e_commerce_app/features/main_layout/lazy_tab_stack.dart';
import 'package:e_commerce_app/features/main_layout/main_bottom_nav_bar.dart';
import 'package:e_commerce_app/features/main_layout/main_layout_tab.dart';
import 'package:flutter/material.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  static const int _initialTabIndex = 0;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(_initialTabIndex);
  late final List<WidgetBuilder> _tabsBuilder = MainLayoutTab.all
      .map((tab) => tab.builder)
      .toList();

  @override
  void initState() {
    super.initState();
    unawaited(NotificationPermissionService.requestIfNeeded());
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) => _currentIndex.value = index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: CustomDrawer(title: context.appLocalization.route),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.w16,
            vertical: AppHeight.h12,
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: (_, index, _) =>
                LazyTabStack(index: index, tabsBody: _tabsBuilder),
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (_, index, _) => MainBottomNavBar(
            currentIndex: index,
            onTap: _onTabSelected,
            tabs: MainLayoutTab.all,
          ),
        ),
      ),
    );
  }
}
