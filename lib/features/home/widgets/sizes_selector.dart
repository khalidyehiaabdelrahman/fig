import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';

class SizesSelector extends StatelessWidget {
  final List<int> sizes;
  final int? selectedSize;
  final ValueChanged<int> onSizeSelected;

  const SizesSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sizes:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.rt(context),
          ),
        ),
        SizedBox(height: 10.rh(context)),
        Wrap(
          spacing: 8.rw(context),
          runSpacing: 8.rh(context),
          children:
              sizes.map((size) {
                final isSelected = selectedSize == size;
                return GestureDetector(
                  onTap: () => onSizeSelected(size),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.rw(context),
                      vertical: 8.rh(context),
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? Colors.red[300] : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.rr(context)),
                    ),
                    child: Text(
                      size.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.rt(context),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
