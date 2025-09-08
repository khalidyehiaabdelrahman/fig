import 'dart:async';

class IntroTextManager {
  final List<String> texts;
  int currentIndex = 0;
  Timer? _timer;

  IntroTextManager({required this.texts});

  void start(void Function(int) onTextChanged) {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      currentIndex = (currentIndex + 1) % texts.length;
      onTextChanged(currentIndex);
    });
  }

  void dispose() => _timer?.cancel();
}
