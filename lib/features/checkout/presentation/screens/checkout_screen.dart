import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/app_bar/product_app_bar.dart';
import 'package:e_commerce_app/core/widget/button/custom_elevated_button.dart';
import 'package:e_commerce_app/features/checkout/presentation/manager/payment_bloc.dart';
import 'package:e_commerce_app/features/checkout/presentation/widgets/payment_dialog.dart';
import 'package:e_commerce_app/features/checkout/presentation/widgets/payment_method_section.dart';
import 'package:e_commerce_app/features/checkout/presentation/widgets/text_checkout_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CheckoutScreen extends StatefulWidget {
  final int orderPrice;
  const CheckoutScreen({super.key, required this.orderPrice});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final int taxValue = 10;
  int _selectedIndex = 0;
  late final int totalPrice;
  @override
  void initState() {
    super.initState();
    configLoading();
    totalPrice = taxValue + widget.orderPrice;
  }

  void _onItemSelected(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  Future<void> _showSuccessDialog() async {
    await showDialog<void>(
      context: context,
      builder: (_) => PaymentDialog(
        imagePath: Assets.images.successBackgroundImg.path,
        message: AppStrings.paymentSuccessMessage,
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _showFailureDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => PaymentDialog(
        imagePath: Assets.images.failureBackgroundImg.path,
        message: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => getIt<PaymentBloc>(),
        child: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, paymentState) {
            switch (paymentState) {
              case PaymentLoadingState():
                EasyLoading.show(status: AppConstants.loading);
              case CreatePaymentIntentSuccessState():
                EasyLoading.dismiss();
                context.read<PaymentBloc>().add(const PaymentProcessEvent());
              case ProcessPaymentSuccessState():
                EasyLoading.dismiss();
                _showSuccessDialog();
              case PaymentCancelledState():
                EasyLoading.dismiss();
              case ProcessPaymentFailureState():
                EasyLoading.dismiss();
                _showFailureDialog(paymentState.failureMessage);
              case PaymentFailureState():
                EasyLoading.dismiss();
                SnackBarService.showErrorMessage(AppStrings.failureMessage);
              default:
                return;
            }
          },
          builder: (context, paymentState) {
            return Scaffold(
              appBar: ProductAppBar(title: context.appLocalization.checkOut),
              body: SingleChildScrollView(
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.appLocalization.paymentMethods),
                        SizedBox(height: AppHeight.h12),
                        PaymentMethodSection(
                          selectedIndex: _selectedIndex,
                          onSelectedItem: _onItemSelected,
                        ),
                        SizedBox(height: AppHeight.h16),
                        Divider(endIndent: AppWidth.w24, indent: AppWidth.w24),
                        SizedBox(height: AppHeight.h12),
                        TextCheckoutItem(
                          title: context.appLocalization.order,
                          value: widget.orderPrice,
                        ),
                        SizedBox(height: AppHeight.h12),
                        TextCheckoutItem(
                          title: context.appLocalization.tax,
                          value: taxValue,
                        ),
                        SizedBox(height: AppHeight.h16),
                        TextCheckoutItem(
                          title: context.appLocalization.totalPrice,
                          value: totalPrice,
                        ),
                        SizedBox(height: AppHeight.h20),
                        CustomElevatedButton(
                          customChildWidget: Text(
                            context.appLocalization.proceedToPayment,
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorManager.white,
                            ),
                          ),
                          onTap: paymentState is PaymentLoadingState
                              ? null
                              : () {
                                  context.read<PaymentBloc>().add(
                                    CreatePaymentIntentEvent(
                                      params: PaymentParams(
                                        amount: totalPrice,
                                        currency: AppConstants.egyptcurrency,
                                      ),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ).setHorizontalAndVerticalPadding(
                      context,
                      AppWidth.w12,
                      AppHeight.h8,
                      enableMediaQuery: false,
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
