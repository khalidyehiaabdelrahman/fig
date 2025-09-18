import 'package:flutter/material.dart';
import 'common_app_bar.dart';

class BaseScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool showBackButton;
  final bool wrapWithSafeArea;
  final bool wrapWithScrollView;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;

  const BaseScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.leading,
    this.bottom,
    this.showBackButton = false,
    this.wrapWithSafeArea = true,
    this.wrapWithScrollView = false,
    this.padding,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget = body;

    
    if (padding != null) {
      bodyWidget = Padding(padding: padding!, child: bodyWidget);
    }

    
    if (wrapWithScrollView) {
      bodyWidget = SingleChildScrollView(child: bodyWidget);
    }

    
    if (wrapWithSafeArea) {
      bodyWidget = SafeArea(child: bodyWidget);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          title != null
              ? CommonAppBar(
                title: title!,
                actions: actions,
                leading: leading,
                bottom: bottom,
                showBackButton: showBackButton,
              )
              : null,
      body: bodyWidget,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }
}
