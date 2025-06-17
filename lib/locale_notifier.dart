import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = const Locale('zh');
  static const String _localePrefsKey = 'app_locale';
  
  LocaleNotifier() {
    _loadSavedLocale();
  }

  Locale get locale => _locale;

  // 从SharedPreferences加载保存的语言设置
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLocale = prefs.getString(_localePrefsKey);
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
      notifyListeners();
    }
  }

  // 设置新的语言并保存到SharedPreferences
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    
    // 保存设置到本地
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localePrefsKey, locale.languageCode);
    
    notifyListeners();
  }
} 