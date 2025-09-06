// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class ThemeProvider with ChangeNotifier, WidgetsBindingObserver {
  bool _isDarkMode = false;
  bool _useSystemTheme = true;
  Brightness? _lastSystemBrightness;

  bool get isDarkMode => _isDarkMode;
  bool get useSystemTheme => _useSystemTheme;

  ThemeProvider() {
    _initTheme();
  }

  Future<void> _initTheme() async {
    WidgetsBinding.instance.addObserver(this);
    await _loadThemePreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (_useSystemTheme) {
      _updateFromSystem();
    }
    super.didChangePlatformBrightness();
  }

  Future<void> _loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _useSystemTheme = prefs.getBool('useSystemTheme') ?? true;
    
    if (_useSystemTheme) {
      _updateFromSystem();
    } else {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    }
    
    notifyListeners();
  }

  void _updateFromSystem() {
    final systemBrightness = WidgetsBinding.instance.window.platformBrightness;
    
    // Éviter les notifications inutiles si la luminosité n'a pas changé
    if (_lastSystemBrightness != systemBrightness) {
      _lastSystemBrightness = systemBrightness;
      _isDarkMode = systemBrightness == Brightness.dark;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _useSystemTheme = false;
    _isDarkMode = !_isDarkMode;
    
    await prefs.setBool('useSystemTheme', _useSystemTheme);
    await prefs.setBool('isDarkMode', _isDarkMode);
    
    notifyListeners();
  }

  Future<void> setUseSystemTheme(bool useSystem) async {
    final prefs = await SharedPreferences.getInstance();
    _useSystemTheme = useSystem;
    
    if (_useSystemTheme) {
      _updateFromSystem();
    }
    
    await prefs.setBool('useSystemTheme', _useSystemTheme);
    notifyListeners();
  }

  Future<void> setDarkMode(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    _useSystemTheme = false;
    _isDarkMode = darkMode;
    
    await prefs.setBool('useSystemTheme', _useSystemTheme);
    await prefs.setBool('isDarkMode', _isDarkMode);
    
    notifyListeners();
  }

  // Méthode pour forcer une mise à jour depuis le système
  void updateFromSystem() {
    if (_useSystemTheme) {
      _updateFromSystem();
    }
  }

  // Méthode pour obtenir le statut actuel du thème
  String getThemeStatus() {
    if (_useSystemTheme) {
      return 'Système';
    }
    return _isDarkMode ? 'Sombre' : 'Clair';
  }
}