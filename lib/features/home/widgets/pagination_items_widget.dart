import 'package:flutter/material.dart';
import 'package:fig/core/widgets/loading_indicator.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';

class PaginationItemsWidget extends StatelessWidget {
  final PaginationLoaded state;

  const PaginationItemsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var item in state.items) {
      widgets.add(
        Container(
          height: 200,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(item, fit: BoxFit.cover),
          ),
        ),
      );
    }

    if (state.hasMore) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: LoadingIndicator(color: Colors.red.shade800)),
        ),
      );
    }

    return Column(children: widgets);
  }
}
