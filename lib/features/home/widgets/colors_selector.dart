import 'package:flutter/material.dart';

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
        const Text("Colors:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children:
              colors.map((color) {
                final isSelected = selectedColor == color;
                return GestureDetector(
                  onTap: () => onColorSelected(color),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: parseColor(color),
                      shape: BoxShape.circle,
                      border:
                          isSelected
                              ? Border.all(color: Colors.black, width: 2)
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
