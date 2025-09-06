// lib/providers/language_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en', 'US');
  bool _useSystemLanguage = true;

  Locale get locale => _locale;
  bool get useSystemLanguage => _useSystemLanguage;

  // Liste des langues supportées
  static final List<Locale> supportedLocales = const [
    Locale('en', 'US'),
    Locale('fr', 'FR'),
    Locale('es', 'ES'),
    Locale('de', 'DE'),
    Locale('ru', 'RU'),
    Locale('zh', 'CN'),
    Locale('ja', 'JP'),
    Locale('he', 'IL'),
    Locale('pl', 'PL'),
    Locale('ar', 'SA'),
  ];

  LanguageProvider() {
    _loadLanguagePreferences();
  }

  Future<void> _loadLanguagePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _useSystemLanguage = prefs.getBool('useSystemLanguage') ?? true;
    
    if (_useSystemLanguage) {
      // Utiliser la langue du système
      _detectSystemLanguage();
    } else {
      // Utiliser la langue sauvegardée
      final savedLanguage = prefs.getString('language');
      final savedCountry = prefs.getString('country');
      if (savedLanguage != null) {
        _locale = Locale(savedLanguage, savedCountry);
      }
    }
    
    notifyListeners();
  }

  void _detectSystemLanguage() {
    final systemLocale = WidgetsBinding.instance.window.locales.first;
    
    // Trouver la meilleure correspondance parmi les langues supportées
    for (final supportedLocale in supportedLocales) {
      if (systemLocale.languageCode == supportedLocale.languageCode) {
        _locale = supportedLocale;
        return;
      }
    }
    
    // Si aucune correspondance exacte, chercher par code de langue seulement
    for (final supportedLocale in supportedLocales) {
      if (systemLocale.languageCode == supportedLocale.languageCode) {
        _locale = supportedLocale;
        return;
      }
    }
    
    // Par défaut en anglais si aucune correspondance
    _locale = const Locale('en', 'US');
  }

  Future<void> setLanguage(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    _useSystemLanguage = false;
    _locale = newLocale;
    
    await prefs.setBool('useSystemLanguage', _useSystemLanguage);
    await prefs.setString('language', newLocale.languageCode);
    if (newLocale.countryCode != null) {
      await prefs.setString('country', newLocale.countryCode!);
    }
    
    notifyListeners();
  }

  Future<void> setSystemLanguage(bool useSystem) async {
    final prefs = await SharedPreferences.getInstance();
    _useSystemLanguage = useSystem;
    
    if (_useSystemLanguage) {
      _detectSystemLanguage();
    }
    
    await prefs.setBool('useSystemLanguage', _useSystemLanguage);
    notifyListeners();
  }

  void updateFromSystem() {
    if (_useSystemLanguage) {
      _detectSystemLanguage();
      notifyListeners();
    }
  }

  // Méthode pour obtenir le nom de la langue actuelle
  String getCurrentLanguageName() {
    switch (_locale.languageCode) {
      case 'en': return 'English';
      case 'fr': return 'Français';
      case 'es': return 'Español';
      case 'de': return 'Deutsch';
      case 'ru': return 'Русский';
      case 'zh': return '中文';
      case 'ja': return '日本語';
      case 'he': return 'עברית';
      case 'pl': return 'Polski';
      case 'ar': return 'العربية';
      default: return 'English';
    }
  }
}