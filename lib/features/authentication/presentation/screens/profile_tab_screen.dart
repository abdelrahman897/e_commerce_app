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
import 'package:e_commerce_app/features/authentication/presentation/widgets/text_form_field_item.dart';
import 'package:e_commerce_app/features/authentication/presentation/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfileTabScreen extends StatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final GlobalKey<FormState> _keyForm;
  late final AuthenticationBloc _authenticationBloc;
  bool _isFullNameReadOnly = true;
  bool _isEmailReadOnly = true;
  bool _isMobileNumberReadOnly = true;
  bool _isAddressReadOnly = false;
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    configLoading();
    _authenticationBloc = context.read<AuthenticationBloc>();
    _fullNameController = TextEditingController(
      text: _authenticationBloc.profile.name,
    );
    _phoneNumberController = TextEditingController(
      text: _authenticationBloc.profile.phoneNumber,
    );
    _emailController = TextEditingController(
      text: _authenticationBloc.profile.email,
    );
    _addressController = TextEditingController(
      text: _authenticationBloc.profile.address?.details ?? '',
    );
    _keyForm = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _refreshFromProfile() {
    _fullNameController.text = _authenticationBloc.profile.name;
    _phoneNumberController.text = _authenticationBloc.profile.phoneNumber ?? '';
    _emailController.text = _authenticationBloc.profile.email;
    _addressController.text =
        _authenticationBloc.profile.address?.details ?? '';
  }

  List<String> _splitAddress(String value) {
    return value.split(',');
  }

  void _resetToReadOnly() {
    setState(() {
      _isFullNameReadOnly = true;
      _isEmailReadOnly = true;
      _isMobileNumberReadOnly = true;
      _isAddressReadOnly = true;
      _isUpdate = false;
    });
  }

  void _enableEditing(VoidCallback function) {
    setState(() {
      function();
      _isUpdate = true;
    });
  }

  void _submitProfileUpdate() {
    if (!_keyForm.currentState!.validate()) return;

    final bool hasDataChanges =
        (_isFullNameReadOnly == false ||
            _isEmailReadOnly == false ||
            _isMobileNumberReadOnly == false) &&
        _isAddressReadOnly == true;
    final bool hasAddressChange =
        _isAddressReadOnly == false &&
        (_isFullNameReadOnly == true ||
            _isEmailReadOnly == true ||
            _isMobileNumberReadOnly == true);

    final bool hasDataAndAddressChange =
        (_isFullNameReadOnly == false ||
            _isEmailReadOnly == false ||
            _isMobileNumberReadOnly == false) &&
        _isAddressReadOnly == false;

    if (hasDataChanges) {
      _dataChange();
    }

    if (hasAddressChange) {
      _addressChange();
    }
    if (hasDataAndAddressChange) {
      _dataChange();
      _addressChange();
    }
  }

  void _addressChange() {
    final List<String> addressParts = _splitAddress(_addressController.text);
    if (addressParts.length < 2) {
      SnackBarService.showErrorMessage(AppStrings.failureMessage);
      return;
    }
    if (_authenticationBloc.profile.address != null) {
      _authenticationBloc.add(
        DeleteAddressEvent(
          addressParams: AddressParams(
            userId: _authenticationBloc.profile.address!.id,
          ),
        ),
      );
    }

    _authenticationBloc.add(
      AddAddressEvent(
        addressParams: AddressParams(
          city: addressParts.first,
          details: addressParts[1],
          phone: _authenticationBloc.profile.phoneNumber,
          name: _authenticationBloc.profile.name,
        ),
      ),
    );
  }

  void _dataChange() {
    _authenticationBloc.add(
      UpdateUserDataEvent(
        updateDataParams: UserUpdateDataParams(
          name: _fullNameController.text,
          email: _emailController.text,
          phone: _phoneNumberController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, updateUserState) {
          switch (updateUserState) {
            case ProfileCachedState():
              _refreshFromProfile();
            case AuthenticationLoadingState():
              EasyLoading.show(status: AppConstants.loading);
            case UpdateProfileSuccessState():
              EasyLoading.dismiss();
              EasyLoading.showSuccess(AppConstants.success);
              SnackBarService.showSuccessMessage(
                AppStrings.updateProfileSuccessMessage,
              );
              _refreshFromProfile();
              _resetToReadOnly();
            case ProfileEmptyState():
              EasyLoading.dismiss();
              _addressController.clear();
              _resetToReadOnly();
            case SignOutSuccessState():
              EasyLoading.dismiss();
              SnackBarService.showSuccessMessage(
                AppStrings.signOutSuccessMessage,
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginRoute,
                (route) => false,
              );
            case AuthenticationFailureState():
              EasyLoading.dismiss();
              SnackBarService.showErrorMessage(AppStrings.failureMessage);
            default:
              return;
          }
        },
        builder: (context, updateUserState) {
          return Form(
            key: _keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(userGmail: _authenticationBloc.profile.email),
                SizedBox(height: AppHeight.h25),
                TextFormFieldItem(
                  key: const Key(WidgetKeys.fullNameFormField),
                  title: context.appLocalization.fullNameTitle,
                  readOnly: _isFullNameReadOnly,
                  hint: context.appLocalization.fullNameHint,
                  controller: _fullNameController,
                  validator: AppValidators.validateFullName,
                  customPrefixWidget: Assets.icons.userIcn.svg(
                    color: context.customColorScheme.text,
                  ),
                  textInputType: TextInputType.name,
                  isEditing: true,
                  onTap: () =>
                      _enableEditing(() => _isFullNameReadOnly = false),
                ),
                SizedBox(height: AppHeight.h16),
                TextFormFieldItem(
                  key: const Key(WidgetKeys.emailFormField),
                  title: context.appLocalization.emailTitle,
                  hint: context.appLocalization.emailHint,
                  controller: _emailController,
                  validator: AppValidators.validateEmail,
                  customPrefixWidget: Assets.icons.emailIcn.svg(
                    color: context.customColorScheme.text,
                  ),
                  textInputType: TextInputType.text,
                  readOnly: _isEmailReadOnly,
                  isEditing: true,
                  onTap: () => _enableEditing(() => _isEmailReadOnly = false),
                ),
                SizedBox(height: AppHeight.h16),
                TextFormFieldItem(
                  key: const Key(WidgetKeys.phoneFormField),
                  title: context.appLocalization.mobileNumberTitle,
                  readOnly: _isMobileNumberReadOnly,
                  hint: context.appLocalization.phoneNumberHint,
                  controller: _phoneNumberController,
                  validator: AppValidators.validatePhoneNumber,
                  customPrefixWidget: Assets.icons.phoneIcn.svg(
                    color: context.customColorScheme.text,
                  ),
                  textInputType: TextInputType.number,
                  isEditing: true,
                  onTap: () =>
                      _enableEditing(() => _isMobileNumberReadOnly = false),
                ),
                SizedBox(height: AppHeight.h16),
                TextFormFieldItem(
                  key: const Key(WidgetKeys.addressFormField),
                  title: context.appLocalization.addressTitle,
                  hint: context.appLocalization.addressHint,
                  readOnly: _isAddressReadOnly,
                  validator: AppValidators.validateEgyptAddress,
                  controller: _addressController,
                  textInputType: TextInputType.text,
                  isEditing: true,
                  onTap: () => _enableEditing(() => _isAddressReadOnly = false),
                  customPrefixWidget: Icon(
                    Icons.location_on_outlined,
                    color: context.customColorScheme.text,
                  ),
                ),
                SizedBox(height: AppHeight.h30),
                CustomElevatedButton(
                  backgroundColor: context.customColorScheme.container,
                  borderRadius: AppRadius.r10,
                  borderSideColor: context.customColorScheme.button,
                  height: AppHeight.h40,
                  customChildWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.appLocalization.signOut,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: context.customColorScheme.button,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: context.customColorScheme.button,
                      ),
                    ],
                  ),
                  onTap: () {
                    context.read<AuthenticationBloc>().add(SignOutEvent());
                  },
                ),
                Visibility(
                  visible: _isUpdate,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppHeight.h10),
                      child: CustomElevatedButton(
                        key: const Key(WidgetKeys.updateProfileElevatedButton),
                        customChildWidget: Text(
                          context.appLocalization.updateProfile,
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorManager.white,
                          ),
                        ),
                        onTap: () {
                          _submitProfileUpdate();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ).setHorizontalPaddingOnWidget(AppWidth.w8),
          );
        },
      ),
    );
  }
}
