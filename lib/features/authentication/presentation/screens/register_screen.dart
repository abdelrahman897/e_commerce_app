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
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_logo_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/text_form_field_item.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/toggle_rigster_password_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final GlobalKey<FormState> _keyForm;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;
  bool isPasswordHidden = true;
  bool isRePasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _keyForm = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, signUpState) {
        switch (signUpState) {
          case AuthenticationLoadingState():
            configLoading();
            EasyLoading.show(status: AppConstants.loading);
          case SignUpSuccessState():
            EasyLoading.dismiss();
            EasyLoading.showSuccess(AppConstants.success);
            SnackBarService.showSuccessMessage(AppStrings.signUpSuccessMessage);
            Navigator.pop(context);
          case SignInOrSignUpWithGoogleSuccessState():
            EasyLoading.dismiss();
            EasyLoading.showSuccess(AppConstants.success);
            SnackBarService.showSuccessMessage(AppStrings.loginSuccessMessage);
            Navigator.pop(context);
          case AuthenticationFailureState():
            EasyLoading.dismiss();
            SnackBarService.showErrorMessage(signUpState.failureMessage);
          default:
            return;
        }
      },
      builder: (context, signUpState) {
        return SafeArea(
          child: Scaffold(
            body: Form(
              key: _keyForm,
              child: SingleChildScrollView(
                key: const Key(WidgetKeys.registerScrollView),
                physics: const BouncingScrollPhysics(),
                child:
                    Column(
                      children: [
                        HeaderLogoSection(),
                        SizedBox(height: AppHeight.h20),
                        TextFormFieldItem(
                          key: const Key(WidgetKeys.fullNameFormField),
                          title: context.appLocalization.fullName,
                          hint: context.appLocalization.fullNameHint,
                          controller: _fullNameController,
                          validator: AppValidators.validateFullName,
                          customPrefixWidget: Assets.icons.userIcn.svg(
                            color: context.customColorScheme.text,
                          ),
                          textInputType: TextInputType.name,
                          nextFocus: _phoneFocusNode,
                        ),
                        SizedBox(height: AppHeight.h16),
                        TextFormFieldItem(
                          key: const Key(WidgetKeys.phoneFormField),
                          title: context.appLocalization.phoneNumber,
                          hint: context.appLocalization.phoneNumberHint,
                          controller: _phoneNumberController,
                          validator: AppValidators.validatePhoneNumber,
                          customPrefixWidget: Assets.icons.phoneIcn.svg(
                            color: context.customColorScheme.text,
                          ),
                          textInputType: TextInputType.number,
                          nextFocus: _emailFocusNode,
                          focusNode: _phoneFocusNode,
                        ),
                        SizedBox(height: AppHeight.h16),
                        TextFormFieldItem(
                          key: const Key(WidgetKeys.emailFormField),
                          title: context.appLocalization.email,
                          hint: context.appLocalization.emailHint,
                          controller: _emailController,
                          validator: AppValidators.validateEmail,
                          customPrefixWidget: Assets.icons.emailIcn.svg(
                            color: context.customColorScheme.text,
                          ),
                          textInputType: TextInputType.text,
                          nextFocus: _passwordFocusNode,
                          focusNode: _emailFocusNode,
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
                          nextFocus: _confirmPasswordFocusNode,
                          focusNode: _passwordFocusNode,
                          customSuffixWidget: ToggleRigsterPasswordButton(
                            onTap: () {
                              isPasswordHidden = !isPasswordHidden;

                              setState(() {});
                            },
                            isPassword: true,
                            isPasswordHidden: isPasswordHidden,
                            isRePasswordHidden: isRePasswordHidden,
                          ),
                        ),
                        SizedBox(height: AppHeight.h16),
                        TextFormFieldItem(
                          key: const Key(WidgetKeys.rePasswordFormField),
                          title: context.appLocalization.rePassword,
                          hint: context.appLocalization.rePasswordHint,
                          controller: _confirmPasswordController,
                          isObscured: isRePasswordHidden,
                          validator: (value) {
                            return AppValidators.validateConfirmPassword(
                              value,
                              _passwordController.text,
                            );
                          },
                          customPrefixWidget: Assets.icons.lockIcn.svg(
                            color: context.customColorScheme.text,
                          ),
                          textInputType: TextInputType.text,
                          focusNode: _confirmPasswordFocusNode,
                          customSuffixWidget: ToggleRigsterPasswordButton(
                            onTap: () {
                              isRePasswordHidden = !isRePasswordHidden;

                              setState(() {});
                            },
                            isRePassword: true,
                            isPasswordHidden: isPasswordHidden,
                            isRePasswordHidden: isRePasswordHidden,
                          ),
                        ),
                        SizedBox(height: AppHeight.h20),
                        CustomElevatedButton(
                          key: const Key(WidgetKeys.signUpElevatedButton),
                          customChildWidget: Text(
                            context.appLocalization.signup,
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorManager.white,
                            ),
                          ),
                          onTap: () {
                            if (_keyForm.currentState!.validate()) {
                              final user = SignUpParams(
                                name: _fullNameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                rePassword: _confirmPasswordController.text,
                                phone: _phoneNumberController.text,
                              );
                              context.read<AuthenticationBloc>().add(
                                SignUpEvent(signUpParams: user),
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
                            WidgetKeys.signUpWithGoogleElevatedButton,
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
                            children: [
                              Assets.icons.googleIcn.svg(),
                              SizedBox(width: AppWidth.w4),
                              Flexible(
                                child: Text(
                                  context.appLocalization.signUpWithGoogle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: context.customColorScheme.button,
                                    fontSize: FontSize.s20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BottomTextSection(
                          key: const Key(WidgetKeys.signUpTextButton),
                          onTap: () => Navigator.popAndPushNamed(
                            context,
                            Routes.loginRoute,
                          ),
                          leftText: context.appLocalization.alreadyHaveAccount,
                          rightText: context.appLocalization.login,
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
