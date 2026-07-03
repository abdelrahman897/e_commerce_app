import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/widget/button/custom_elevated_button.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_logo_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/image_forget_password_section.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/text_form_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final GlobalKey<FormState> _keyForm;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _keyForm = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, forgetPasswordState) {
        switch (forgetPasswordState) {
          case AuthenticationLoadingState():
            configLoading();
            EasyLoading.show(status: AppConstants.loading);
          case ForgetPasswordSuccessState():
            EasyLoading.dismiss();
            EasyLoading.showSuccess(AppConstants.success);
            SnackBarService.showSuccessMessage(
              AppStrings.forgetPasswordSuccessMessage,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainLayoutRoute,
              (route) => false,
              //arguments: forgetPasswordState.forgetPasswordEntity.message,
            );
          case AuthenticationFailureState():
            EasyLoading.dismiss();
            SnackBarService.showErrorMessage(
              forgetPasswordState.failureMessage,
            );
          default:
            return;
        }
      },
      builder: (context, forgetPasswordState) {
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
                        ImageForgetPasswordSection(),
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
                        ),
                        SizedBox(height: AppHeight.h20),
                        CustomElevatedButton(
                          key: const Key(WidgetKeys.forgetPasswordElevatedButton),
                          customChildWidget: Text(
                            context.appLocalization.verifyEmail,
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorManager.white,
                            ),
                          ),
                          onTap: () {
                            if (_keyForm.currentState!.validate()) {
                              final params = ForgetPasswordParams(
                                email: _emailController.text,
                              );
                              context.read<AuthenticationBloc>().add(
                                ForgetPasswordEvent(
                                  forgetPasswordParams: params,
                                ),
                              );
                            }
                          },
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
