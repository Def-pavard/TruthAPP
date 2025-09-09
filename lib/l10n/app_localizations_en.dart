// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'Text Verification';

  @override
  String get imageForensics => 'Image Forensics';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'Analyze a text, article or statement';

  @override
  String get welcomeForensics =>
      'Welcome to Forensics mode. Upload an image to analyze its origin, detect manipulations and verify its context. Truth is in the details.';

  @override
  String get welcomeDaily =>
      'Truth Daily is your real-time information watch. Enter a topic, keyword or event name to get factual and impartial analysis of the latest news.';

  @override
  String get uploadImage => 'Click or drag to upload an image';

  @override
  String get newAnalysis => 'new analysis';

  @override
  String get analysisInProgress => 'Analysis in progress...';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemTheme => 'System Theme';

  @override
  String get language => 'Language';

  @override
  String get systemLanguage => 'System Language';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'See more';

  @override
  String get seeLess => 'See less';

  @override
  String get shareResults => 'Share results';

  @override
  String get verdictTrue => 'True';

  @override
  String get verdictMostlyTrue => 'MOSTLY TRUE';

  @override
  String get verdictMixed => 'MIXED';

  @override
  String get verdictMostlyFalse => 'MOSTLY FALSE';

  @override
  String get verdictFalse => 'FALSE';

  @override
  String get verdictUnverifiable => 'unverifiable';

  @override
  String get themeSelection => 'Theme selection';

  @override
  String get themeDescription => 'Choose the appearance of the application';

  @override
  String get systemThemeDescription => 'Use system theme';
}
