// 📁 lib/core/widget/drawer/sub_widget/custom_dropdown_menu.dart

import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  final ValueChanged<T?>? onSelected;
  final List<DropdownMenuEntry<T>> items;
  final T selectedItem;

  const CustomDropdownMenu({
    super.key,
    this.onSelected,
    required this.items,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<T>(
          width: constraints.maxWidth,
          onSelected: onSelected,
          initialSelection: selectedItem,
          textStyle: context.textTheme.bodyMedium?.copyWith(
            color: context.customColorScheme.text,
          ),
          textAlign: TextAlign.start,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: context.customColorScheme.container,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppWidth.w12,
              vertical: AppHeight.h12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              borderSide: BorderSide(color: context.customColorScheme.button),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              borderSide: BorderSide(color: context.customColorScheme.button),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              borderSide: BorderSide(
                color: context.customColorScheme.button,
                width: 1,
              ),
            ),
          ),
          trailingIcon: Icon(
            Icons.expand_more,
            color: context.customColorScheme.text,
          ),
          selectedTrailingIcon: Icon(
            Icons.expand_less,
            color: context.customColorScheme.button,
          ),
          dropdownMenuEntries: items,
        );
      },
    );
  }
}
