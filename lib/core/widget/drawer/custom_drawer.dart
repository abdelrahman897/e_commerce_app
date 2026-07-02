import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/cubit/language/language_state.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_cubit.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_state.dart';
import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/drawer/sub_widget/custom_dropdown_menu.dart';
import 'package:e_commerce_app/core/widget/drawer/sub_widget/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  final String title;
  const CustomDrawer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * 0.56,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                title,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.customColorScheme.button,
                ),
              ),
            ),
          ),
          SizedBox(height: AppHeight.h25),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return DrawerItem(
                titleItem: context.appLocalization.theme,
                icon: Assets.icons.themeIcn.svg(
                  colorFilter: ColorFilter.mode(
                    context.customColorScheme.button,
                    BlendMode.srcIn,
                  ),
                ),
                dropdownWidget: CustomDropdownMenu<ThemeMode>(
                  onSelected: (mode) {
                    if (mode == null) return;
                    context.read<ThemeCubit>().setTheme(mode);
                  },
                  items: [
                    DropdownMenuEntry(
                      value: ThemeMode.light,
                      label: context.appLocalization.light,
                    ),
                    DropdownMenuEntry(
                      value: ThemeMode.dark,
                      label: context.appLocalization.dark,
                    ),
                  ],
                  selectedItem: themeState.themeMode,
                ),
              );
            },
          ),
          SizedBox(height: AppHeight.h16),
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return DrawerItem(
                titleItem: context.appLocalization.language,
                icon: Assets.icons.worldIcn.svg(
                  colorFilter: ColorFilter.mode(
                    context.customColorScheme.button,
                    BlendMode.srcIn,
                  ),
                ),
                dropdownWidget: CustomDropdownMenu<Locale>(
                  onSelected: (locale) {
                    if (locale == null) return;
                    context.read<LanguageCubit>().setLanguage(locale);
                  },
                  items: [
                    DropdownMenuEntry(
                      value: const Locale(AppConstants.en),
                      label: context.appLocalization.english,
                    ),
                    DropdownMenuEntry(
                      value: const Locale(AppConstants.ar),
                      label: context.appLocalization.arabic,
                    ),
                  ],
                  selectedItem: languageState.locale,
                ),
              );
            },
          ),
        ],
      ).setHorizontalPaddingOnWidget(AppWidth.w16),
    );
  }
}
