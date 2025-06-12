import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  static const _key = 'app_theme_color';
  MaterialColor _color = Colors.amber;
  MaterialColor get color => _color;

  ThemeNotifier() {
    _loadTheme();
  }

  void setColor(MaterialColor color) async {
    _color = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_key, _materialColorToInt(color));
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_key);
    if (value != null) {
      _color = _intToMaterialColor(value);
      notifyListeners();
    }
  }

  // 只支持常用主色
  static int _materialColorToInt(MaterialColor color) {
    if (color == Colors.amber) return 0;
    if (color == Colors.blue) return 1;
    if (color == Colors.green) return 2;
    if (color == Colors.red) return 3;
    if (color == Colors.purple) return 4;
    if (color == Colors.teal) return 5;
    if (color == Colors.orange) return 6;
    return 0;
  }

  static MaterialColor _intToMaterialColor(int value) {
    switch (value) {
      case 1: return Colors.blue;
      case 2: return Colors.green;
      case 3: return Colors.red;
      case 4: return Colors.purple;
      case 5: return Colors.teal;
      case 6: return Colors.orange;
      default: return Colors.amber;
    }
  }
} 