import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/widget/button/custom_elevated_button.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/bottom_text_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/custom_divider_line_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/forget_password_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_authentication_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_logo_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/text_form_field_item.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/toggle_password_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _keyForm;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _passwordFocusNode;
  bool isPasswordHidden = true;
  

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    configLoading();
    _keyForm = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, signInState) {
        switch (signInState) {
          case AuthenticationLoadingState():
            EasyLoading.show(status: AppConstants.loading);
          case SignInSuccessState():
            EasyLoading.dismiss();
            EasyLoading.showSuccess(AppConstants.success);
            SnackBarService.showSuccessMessage(AppStrings.loginSuccessMessage);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainLayoutRoute,
              (route) => false,
            );
          case SignInOrSignUpWithGoogleSuccessState():
            EasyLoading.dismiss();
            EasyLoading.showSuccess(AppConstants.success);
            SnackBarService.showSuccessMessage(AppStrings.loginSuccessMessage);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainLayoutRoute,
              (route) => false,
            );
          case AuthenticationFailureState():
            EasyLoading.dismiss();
            SnackBarService.showErrorMessage(AppStrings.failureMessage);
          default:
            return;
        }
      },
      builder: (context, signInState) {
        return SafeArea(
          child: Scaffold(
            body: Form(
              key: _keyForm,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child:
                    Column(
                      children: [
                        HeaderLogoSection(),
                        SizedBox(height: AppHeight.h25),
                        Align(
                          alignment: Alignment.topLeft,
                          child: HeaderAuthenticationSection(
                            title: context.appLocalization.loginTitle,
                            subtitle: context.appLocalization.loginSubTitle,
                          ),
                        ),
                        SizedBox(height: AppHeight.h25),
                        TextFormFieldItem(
                          key: const Key(WidgetKeys.emailFormField),
                          title: context.appLocalization.email,
                          hint: context.appLocalization.emailHint,
                          controller: _emailController,
                          validator: AppValidators.validateEmail,
                          customPrefixWidget: Assets.icons.emailIcn.svg(
                            color: context.customColorScheme.text,
                          ),
                          textInputType: TextInputType.emailAddress,
                          nextFocus: _passwordFocusNode,
                        ),
                        SizedBox(height: AppHeight.h16),
                        TextFormFieldItem(
                          key: const Key(WidgetKeys.passwordFormField),
                          title: context.appLocalization.password,
                          hint: context.appLocalization.passwordHint,
                          controller: _passwordController,
                          isObscured: isPasswordHidden,
                          validator: AppValidators.validatePassword,
                          customPrefixWidget: Assets.icons.lockIcn.svg(
                            color: context.customColorScheme.text,
                          ),
                          textInputType: TextInputType.text,
                          focusNode: _passwordFocusNode,
                          customSuffixWidget: TogglePasswordButton(
                            isPasswordHidden: isPasswordHidden,
                            onTap: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: AppHeight.h8),
                        ForgetPasswordSection(
                          key: const Key(WidgetKeys.forgetPasswordTextButton),
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            Routes.forgetPasswordRoute,
                          ),
                        ),
                        SizedBox(height: AppHeight.h20),
                        CustomElevatedButton(
                          key: const Key(WidgetKeys.signInElevatedButton),
                          customChildWidget: Text(
                            context.appLocalization.login,
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorManager.white,
                            ),
                          ),
                          onTap: () {
                            if (_keyForm.currentState!.validate()) {
                              final params = SignInParams(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              context.read<AuthenticationBloc>().add(
                                SignInEvent(signInParams: params),
                              );
                            }
                          },
                        ),
                        SizedBox(height: AppHeight.h20),
                        CustomDividerLineSection(
                          text: context.appLocalization.or,
                        ),
                        SizedBox(height: AppHeight.h16),
                        CustomElevatedButton(
                          key: const Key(
                            WidgetKeys.signInWithGoogleElevatedButton,
                          ),
                          onTap: () {
                            context.read<AuthenticationBloc>().add(
                              SignInOrSignUpEvent(),
                            );
                          },
                          borderSideColor: context.customColorScheme.button,
                          backgroundColor: context.customColorScheme.primary,
                          customChildWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: AppWidth.w4,
                            children: [
                              Assets.icons.googleIcn.svg(),
                              Flexible(
                                child: Text(
                                  context.appLocalization.loginWithGoogle,
                                  style: TextStyle(
                                    color: context.customColorScheme.button,
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppHeight.h16),
                        BottomTextSection(
                          key: const Key(WidgetKeys.signInTextButton),
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.registerRoute,
                          ),
                          leftText: context.appLocalization.doNotHaveAccount,
                          rightText: context.appLocalization.signup,
                          rightTextColor: context.customColorScheme.button,
                        ),
                      ],
                    ).setHorizontalAndVerticalPadding(
                      context,
                      25,
                      50,
                      enableMediaQuery: false,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
