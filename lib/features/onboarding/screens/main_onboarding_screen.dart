import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/cubit/language/language_state.dart';
import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_cubit.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_state.dart';
import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/is_dark_mode.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/widget/button/custom_elevated_button.dart';
import 'package:e_commerce_app/features/onboarding/widgets/paragraph_section.dart';
import 'package:e_commerce_app/features/onboarding/widgets/select_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainOnboardingScreen extends StatelessWidget {
  const MainOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child:
            Column(
              children: [
                context.isDarkMode
                    ? Assets.images.darkMainOnboardingBackgroundImg.image()
                    : Assets.images.lightMainOnboardingBackgroundImg.image(),
                SizedBox(height: AppHeight.h24),
                ParagraphSection(
                  title: context.appLocalization.mainOnboardingTitle,
                  body: context.appLocalization.mainOnboardingBody,
                ),
                SizedBox(height: AppHeight.h16),
                _selectLanguageAndTheme(),
                SizedBox(height: AppHeight.h24),
                CustomElevatedButton(
                  customChildWidget: Text(
                    context.appLocalization.getStarted,
                    style: TextStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.white,
                    ),
                  ),
                  onTap: () {
                    final isComplete = context
                        .read<OnboardingCubit>()
                        .state
                        .isComplete;
                        /*
                        final isSignIn = context
                        .read<AuthenticationBloc>()
                        .isSignIn;

                    if (isSignIn) {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.mainLayoutRoute,
                      );
                    } else
                        */
                     if (isComplete) {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.loginRoute,
                      );
                    } else {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.onboardingPagesRoute,
                      );
                    }
                  },
                ),
              ],
            ).setHorizontalAndVerticalPadding(
              context,
              AppWidth.w16,
              AppHeight.h16,
              enableMediaQuery: false,
            ),
      ),
    );
  }

  Widget _selectLanguageAndTheme() {
    return Column(
      spacing: AppWidth.w18,
      children: [
        BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, languageState) {
            final isEnglish =
                languageState.locale.languageCode == AppConstants.en;
            return SelectItemRow(
              label: context.appLocalization.language,
              isFirstSelected: isEnglish,
              customFirstChild: Text(
                context.appLocalization.english,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: FontSize.s18,
                  color: isEnglish
                      ? ColorManager.white
                      : context.customColorScheme.button,
                ),
              ),
              customSecondChild: Text(
                context.appLocalization.arabic,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: FontSize.s18,
                  color: !isEnglish
                      ? ColorManager.white
                      : context.customColorScheme.button,
                ),
              ),
              onTapFirst: () {
                context.read<LanguageCubit>().setLanguage(
                  const Locale(AppConstants.en),
                );
              },
              onTapSecond: () {
                context.read<LanguageCubit>().setLanguage(
                  const Locale(AppConstants.ar),
                );
              },
            );
          },
        ),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            final isLight = themeState.themeMode == ThemeMode.light;
            return SelectItemRow(
              label: context.appLocalization.theme,
              isFirstSelected: isLight,
              customFirstChild: Assets.icons.sunIcn.svg(
                colorFilter: ColorFilter.mode(
                  isLight
                      ? ColorManager.white
                      : context.customColorScheme.button,
                  BlendMode.srcIn,
                ),
              ),
              customSecondChild: Assets.icons.moonIcn.svg(
                colorFilter: ColorFilter.mode(
                  !isLight
                      ? ColorManager.white
                      : context.customColorScheme.button,
                  BlendMode.srcIn,
                ),
              ),
              onTapFirst: () {
                context.read<ThemeCubit>().setTheme(ThemeMode.light);
              },
              onTapSecond: () {
                context.read<ThemeCubit>().setTheme(ThemeMode.dark);
              },
            );
          },
        ),
      ],
    );
  }
}
