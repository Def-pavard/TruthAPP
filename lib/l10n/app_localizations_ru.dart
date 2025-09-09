// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'Проверка текста';

  @override
  String get imageForensics => 'Криминалистика изображений';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'Проанализируйте текст, статью или заявление';

  @override
  String get welcomeForensics =>
      'Добро пожаловать в режим Forensics. Загрузите изображение для анализа его происхождения, обнаружения манипуляций и проверки контекста. Истина в деталях.';

  @override
  String get welcomeDaily =>
      'Truth Daily - это ваш мониторинг информации в реальном времени. Введите тему, ключевое слово или название события, чтобы получить фактический и беспристрастный анализ последних новостей.';

  @override
  String get uploadImage => 'Нажмите или перетащите для загрузки изображения';

  @override
  String get newAnalysis => 'Новый анализ';

  @override
  String get analysisInProgress => 'Анализ выполняется...';

  @override
  String get darkMode => 'Темный режим';

  @override
  String get lightMode => 'Светлый режим';

  @override
  String get systemTheme => 'Системная тема';

  @override
  String get language => 'Язык';

  @override
  String get systemLanguage => 'Системный язык';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'Подробнее';

  @override
  String get seeLess => 'Скрыть';

  @override
  String get shareResults => 'Поделиться результатами';

  @override
  String get verdictTrue => 'ПРАВДА';

  @override
  String get verdictMostlyTrue => 'В ОСНОВНОМ ПРАВДА';

  @override
  String get verdictMixed => 'СМЕШАННЫЙ';

  @override
  String get verdictMostlyFalse => 'В ОСНОВНОМ ЛОЖЬ';

  @override
  String get verdictFalse => 'ЛОЖЬ';

  @override
  String get verdictUnverifiable => 'НЕПРОВЕРЯЕМО';

  @override
  String get themeSelection => 'Выбор темы';

  @override
  String get themeDescription => 'Выберите внешний вид приложения';

  @override
  String get systemThemeDescription => 'Использовать системную тему';
}
