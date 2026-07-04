import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/size_item.dart';
import 'package:flutter/material.dart';

class SizeBodySection extends StatefulWidget {
  final List<int> sizes;
  final ValueChanged<int> onSelected;
  const SizeBodySection({
    super.key,
    required this.sizes,
    required this.onSelected,
  });

  @override
  State<SizeBodySection> createState() => _SizeBodySectionState();
}

class _SizeBodySectionState extends State<SizeBodySection> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final size = widget.sizes[index];
          final isSelected = index == selected;
          return SizeItem(
            onTap: () {
              setState(() => selected = index);
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
