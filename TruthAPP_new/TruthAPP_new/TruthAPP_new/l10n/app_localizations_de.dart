// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SDe extends S {
  SDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'Textüberprüfung';

  @override
  String get imageForensics => 'Bildforensik';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText =>
      'Analysieren Sie einen Text, Artikel oder eine Aussage';

  @override
  String get welcomeForensics =>
      'Willkommen im Forensics-Modus. Laden Sie ein Bild hoch, um dessen Ursprung zu analysieren, Manipulationen zu erkennen und den Kontext zu überprüfen. Die Wahrheit steckt in den Details.';

  @override
  String get welcomeDaily =>
      'Truth Daily ist Ihre Echtzeit-Informationsüberwachung. Geben Sie ein Thema, ein Schlüsselwort oder einen Ereignisnamen ein, um eine sachliche und unvoreingenommene Analyse der neuesten Nachrichten zu erhalten.';

  @override
  String get uploadImage => 'Klicken oder ziehen Sie, um ein Bild hochzuladen';

  @override
  String get newAnalysis => 'Neue Analyse';

  @override
  String get analysisInProgress => 'Analyse läuft...';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get lightMode => 'Heller Modus';

  @override
  String get systemTheme => 'Systemthema';

  @override
  String get language => 'Sprache';

  @override
  String get systemLanguage => 'Systemsprache';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'Mehr sehen';

  @override
  String get seeLess => 'Weniger sehen';

  @override
  String get shareResults => 'Ergebnisse teilen';

  @override
  String get verdictTrue => 'WAHR';

  @override
  String get verdictMostlyTrue => 'GROßTEILS WAHR';

  @override
  String get verdictMixed => 'GEMISCHT';

  @override
  String get verdictMostlyFalse => 'GROßTEILS FALSCH';

  @override
  String get verdictFalse => 'FALSCH';

  @override
  String get verdictUnverifiable => 'NICHT VERIFIZIERBAR';

  @override
  String get themeSelection => 'Themenauswahl';

  @override
  String get themeDescription =>
      'Wählen Sie das Erscheinungsbild der Anwendung';

  @override
  String get systemThemeDescription => 'Systemthema verwenden';

  @override
  String get deepfakeAlertTitle => 'Deepfake-Warnung';

  @override
  String get deepfakeAlertMessage =>
      'Deepfake: Glauben Sie keine unbestätigten Informationen.';

  @override
  String get enableSocialVigil => 'Soziale Wachsamkeit aktivieren';

  @override
  String get socialVigilDescription =>
      'Wenn aktiviert, erinnert Sie Truth AI dezent bei der Nutzung ausgewählter sozialer Netzwerke.';
}
