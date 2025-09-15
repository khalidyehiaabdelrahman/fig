import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _isGridKey = 'isGrid';

  Future<bool> getIsGrid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isGridKey) ?? true;
  }

  Future<void> setIsGrid(bool isGrid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isGridKey, isGrid);
  }
}
