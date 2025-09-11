import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.rw(context)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.rw(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.rr(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8.rw(context),
              offset: Offset(0, 4.rh(context)),
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Search Product',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
