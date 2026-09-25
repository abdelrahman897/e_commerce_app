import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/size_item.dart';
import 'package:flutter/material.dart';

class SizeBodySection extends StatefulWidget {
  final List<int> sizes;
  final ValueChanged<int> onSelected;
  final int initialIndex;
  const SizeBodySection({
    super.key,
    required this.sizes,
    required this.onSelected,
    this.initialIndex = -1,
  });

  @override
  State<SizeBodySection> createState() => _SizeBodySectionState();
}

class _SizeBodySectionState extends State<SizeBodySection> {
  late int _selectedIndex = widget.initialIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final size = widget.sizes[index];
          final isSelected = index == _selectedIndex;
          return SizeItem(
            onTap: () {
              if (isSelected) return;
              setState(() => _selectedIndex = index);
              widget.onSelected(index);
            },
            sizeNumber: size,
            isSelected: isSelected,
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: AppWidth.w16),
        itemCount: widget.sizes.length,
      ),
    );
  }
}
