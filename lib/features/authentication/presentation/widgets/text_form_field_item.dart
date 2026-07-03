import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/text_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class TextFormFieldItem extends StatelessWidget {
  final String title;
  final String hint;
  final bool isObscured;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool readOnly;
  final Widget? customPrefixWidget;
  final bool isEditing;
  final Widget? customSuffixWidget;
  final VoidCallback? onTap;

  const TextFormFieldItem({
    super.key,
    required this.title,
    required this.hint,
    this.isObscured = false,
    this.controller,
    this.validator,
    this.customPrefixWidget,
    this.textInputType,
    this.customSuffixWidget,
    this.nextFocus,
    this.focusNode,
    this.readOnly = false,
    this.isEditing = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppHeight.h8,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomTextFormField(
          hint: hint,
          controller: controller,
          customPrefixWidget: customPrefixWidget,
          customSuffixWidget:
              customSuffixWidget ??
              (isEditing
                  ? Visibility(
                      visible: readOnly,
                      child: Bounceable(
                        onTap: onTap,
                        child: Assets.icons.editIcn.svg(
                          color: context.customColorScheme.text,
                            width: AppWidth.w16,
                            height: AppHeight.h16,
                        ),
                      ),
                    )
                  : null),
          isObscured: isObscured,
          validator: validator,
          focusNode: focusNode,
          nextFocus: nextFocus,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
