import 'package:flutter/material.dart';


class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  
  static BuildContext? get currentContext => navigatorKey.currentContext;

  
  static Future<T?> push<T>(Widget page) {
    return navigatorKey.currentState!.push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  
  static Future<T?> pushAndRemoveUntil<T>(
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return navigatorKey.currentState!.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      predicate ?? (route) => false,
    );
  }

  
  static Future<T?> pushReplacement<T>(Widget page) {
    return navigatorKey.currentState!.pushReplacement<T, dynamic>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  
  static void pop<T>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }

  
  static void popUntil(bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState!.popUntil(predicate);
  }

  
  static bool canPop() {
    return navigatorKey.currentState!.canPop();
  }

  
  static Future<T?> showAppDialog<T>({
    required Widget dialog,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (_) => dialog,
    );
  }

  
  static Future<T?> showAppBottomSheet<T>({
    required Widget content,
    bool isScrollControlled = false,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: currentContext!,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      builder: (_) => content,
    );
  }

  
  static void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(currentContext!).showSnackBar(
      SnackBar(content: Text(message), duration: duration, action: action),
    );
  }

  
  static void navigateToTab(int index) {
    
    
  }
}


extension NavigationExtension on BuildContext {
  
  Future<T?> pushPage<T>(Widget page) => NavigationService.push<T>(page);

  
  Future<T?> pushAndClearStack<T>(Widget page) =>
      NavigationService.pushAndRemoveUntil<T>(page);

  
  Future<T?> replacePage<T>(Widget page) =>
      NavigationService.pushReplacement<T>(page);

  
  void popPage<T>([T? result]) => NavigationService.pop<T>(result);

  
  Future<T?> showAppDialog<T>(Widget dialog) =>
      NavigationService.showAppDialog<T>(dialog: dialog);

  
  Future<T?> showBottomSheet<T>(Widget content) =>
      NavigationService.showAppBottomSheet<T>(content: content);
}
