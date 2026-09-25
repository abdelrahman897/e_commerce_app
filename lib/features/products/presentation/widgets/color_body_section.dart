import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/color_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class ColorBodySection extends StatefulWidget {
  final List<Color> colors;
  final ValueChanged<int> onSelected;
  final int initialIndex;
  const ColorBodySection({
    super.key,
    required this.colors,
    required this.onSelected,
    this.initialIndex = -1,
  });

  @override
  State<ColorBodySection> createState() => _ColorBodySectionState();
}

class _ColorBodySectionState extends State<ColorBodySection> {
  late int _selectedIndex = widget.initialIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final color = widget.colors[index];
          final isSelected = _selectedIndex == index;
          return Bounceable(
            onTap: () {
              if (isSelected) return;
              setState(() => _selectedIndex = index);
              widget.onSelected(index);
            },
            child: ColorItem(color: color, isSelected: isSelected),
          );
        },
        separatorBuilder: (context, _) => SizedBox(width: AppWidth.w16),
        itemCount: widget.colors.length,
      ),
    );
  }
}
