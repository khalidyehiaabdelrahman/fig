import 'package:flutter/material.dart';

class TopSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    IconData icon = Icons.info,
    Color backgroundColor = Colors.teal,
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
  final VoidCallback onDismiss;
  final Duration duration;

  const _TopSnackBarWidget({
    required this.message,
    required this.icon,
    required this.backgroundColor,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  FadeTransition(
                    opacity: _blinkAnimation,
                    child: Icon(widget.icon, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: dismiss,
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.white,
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
