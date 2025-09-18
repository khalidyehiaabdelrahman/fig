import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';

class TopSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    IconData icon = Icons.info,
    Color backgroundColor = Colors.teal,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return _TopSnackBarWidget(
          message: message,
          icon: icon,
          backgroundColor: backgroundColor,
          textColor: textColor,
          onDismiss: () => overlayEntry.remove(),
          duration: duration,
        );
      },
    );

    overlay.insert(overlayEntry);
  }
}

class _TopSnackBarWidget extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onDismiss;
  final Duration duration;

  const _TopSnackBarWidget({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _slideController.forward();

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _blinkAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );

    Future.delayed(widget.duration, () {
      dismiss();
    });
  }

  void dismiss() {
    _slideController.reverse().then((value) => widget.onDismiss());
  }

  @override
  void dispose() {
    _slideController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          color: widget.backgroundColor,
          elevation: 4,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.rw(context),
                vertical: 12.rh(context),
              ),
              child: Row(
                children: [
                  FadeTransition(
                    opacity: _blinkAnimation,
                    child: Icon(
                      widget.icon,
                      color: widget.textColor,
                      size: 30.rt(context),
                    ),
                  ),
                  SizedBox(width: 20.rw(context)),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: 16.rt(context),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: dismiss,
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: widget.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppMessages {
  static void _showMessage(
    BuildContext context,
    String message,
    IconData icon,
    Color backgroundColor,
  ) {
    TopSnackBar.show(
      context,
      message: message,
      icon: icon,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  static void showError(BuildContext context, String message) {
    _showMessage(context, message, Icons.error, Colors.red);
  }

  static void showSuccess(BuildContext context, String message) {
    _showMessage(context, message, Icons.check_circle, Colors.green);
  }

  static void showInfo(BuildContext context, String message) {
    _showMessage(context, message, Icons.info, Colors.blue);
  }

  static void showWarning(BuildContext context, String message) {
    _showMessage(context, message, Icons.warning, Colors.orange);
  }

  static void showLogout(BuildContext context, String message) {
    _showMessage(context, message, Icons.exit_to_app, Colors.blueGrey);
  }

  static void showSignUpSuccess(BuildContext context, String message) {
    _showMessage(context, message, Icons.person_add, Colors.green);
  }
}

extension AppMessagesExtension on BuildContext {
  void showErrorMessage(String message) => AppMessages.showError(this, message);
  void showSuccessMessage(String message) =>
      AppMessages.showSuccess(this, message);
  void showInfoMessage(String message) => AppMessages.showInfo(this, message);
  void showWarningMessage(String message) =>
      AppMessages.showWarning(this, message);
  void showLogoutMessage(String message) =>
      AppMessages.showLogout(this, message);
  void showSignUpSuccessMessage(String message) =>
      AppMessages.showSignUpSuccess(this, message);
}
