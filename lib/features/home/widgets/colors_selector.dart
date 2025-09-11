import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';

Color parseColor(String color) {
  switch (color.toLowerCase()) {
    case 'black':
      return Colors.black;
    case 'red':
      return Colors.red;
    case 'navy':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'beige':
      return Color(0xFFF5F5DC);
    case 'white':
      return Colors.white;
    case 'grey':
      return Colors.grey;
    default:
      return Colors.grey;
  }
}

class ColorsSelector extends StatelessWidget {
  final List<String> colors;
  final String? selectedColor;
  final ValueChanged<String> onColorSelected;

  const ColorsSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colors:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.rt(context),
          ),
        ),
        SizedBox(height: 10.rh(context)),
        Wrap(
          spacing: 8.rw(context),
          children:
              colors.map((color) {
                final isSelected = selectedColor == color;
                return GestureDetector(
                  onTap: () => onColorSelected(color),
                  child: Container(
                    width: 32.rw(context),
                    height: 32.rh(context),
                    decoration: BoxDecoration(
                      color: parseColor(color),
                      shape: BoxShape.circle,
                      border:
                          isSelected
                              ? Border.all(
                                color: Colors.black,
                                width: 2.rw(context),
                              )
                              : null,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
