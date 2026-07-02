// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _ToastType {
  success,
  //warning,
  error;

  String get iconPath => switch (this) {
    _ToastType.success => Assets.icons.successIcn.path,
    //_ToastType.warning => Assets.icons.warningIcn.path,
    _ToastType.error => Assets.icons.errorIcn.path,
  };
}

class SnackBarService {
  SnackBarService._();

  static void showSuccessMessage(String msg) =>
      _show(message: msg, toastType: _ToastType.success);

  // static void showWarningMessage(String msg, {bool isLoginWarning = false}) =>
  //    _show(message: msg, toastType: _ToastType.warning);

  static void showErrorMessage(String msg) =>
      _show(message: msg, toastType: _ToastType.error);

  static void _show({required String message, required _ToastType toastType}) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 5),
      dismissDirections: [DismissDirection.endToStart],
      toastBuilder: (cancelFunc) => _ToastWidget(
        message: message,
        type: toastType,
        onDismiss: cancelFunc,
      ),
    );
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final _ToastType type;
  final VoidCallback onDismiss;
  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child:
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: AppWidth.w16),
            decoration: BoxDecoration(
              color: context.customColorScheme.primary,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: Row(
              children: [
                _ToastIcon(iconPath: type.iconPath),
                SizedBox(width: AppWidth.w6),
                Expanded(
                  child: Text(
                    message,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.customColorScheme.text,
                    ),
                  ),
                ),
                _DismissButton(onDismiss: onDismiss),
              ],
            ),
          ).setHorizontalAndVerticalPadding(
            context,
            AppWidth.w16,
            AppHeight.h12,
            enableMediaQuery: false,
          ),
    );
  }
}

class _ToastIcon extends StatelessWidget {
  final String iconPath;

  const _ToastIcon({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      height: AppHeight.h20,
      width: AppWidth.w20,
    );
  }
}

class _DismissButton extends StatelessWidget {
  final VoidCallback onDismiss;
  const _DismissButton({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onDismiss,
      icon: const Icon(Icons.close_rounded, color: ColorManager.grey),
    );
  }
}
