import 'package:flutter/material.dart';
import 'package:fig/core/widgets/loading_indicator.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/core/utils/responsive.dart';

class PaginationItemsWidget extends StatelessWidget {
  final PaginationLoaded state;

  const PaginationItemsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var item in state.items) {
      widgets.add(
        Container(
          height: 200.rh(context),
          margin: EdgeInsets.symmetric(vertical: 8.rh(context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.rr(context)),
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.rr(context)),
            child: Image.asset(item, fit: BoxFit.cover),
          ),
        ),
      );
    }

    if (state.hasMore) {
      widgets.add(
        Padding(
          padding: EdgeInsets.all(16.rw(context)),
          child: Center(child: LoadingIndicator(color: Colors.red.shade800)),
        ),
      );
    }

    return Column(children: widgets);
  }
}
