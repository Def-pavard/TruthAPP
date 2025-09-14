// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SFr extends S {
  SFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'Vérification de Texte';

  @override
  String get imageForensics => 'Forensique Image';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'Analysez un texte, un article ou une déclaration';

  @override
  String get welcomeForensics =>
      'Bienvenue dans le mode Forensics. Téléversez une image pour en analyser l\'origine, détecter les manipulations et vérifier son contexte. La vérité est dans les détails.';

  @override
  String get welcomeDaily =>
      'Truth Daily est votre veille d\'information en temps réel. Saisissez un sujet, un mot-clé ou le nom d\'un événement pour obtenir une analyse factuelle et non biaisée des dernières actualités.';

  @override
  String get uploadImage => 'Cliquez ou glissez pour téléverser une image';

  @override
  String get newAnalysis => 'Nouvelle Analyse';

  @override
  String get analysisInProgress => 'Analyse en cours...';

  @override
  String get darkMode => 'Mode Nuit';

  @override
  String get lightMode => 'Mode Jour';

  @override
  String get systemTheme => 'Thème Système';

  @override
  String get language => 'Langue';

  @override
  String get systemLanguage => 'Langue Système';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'Voir plus';

  @override
  String get seeLess => 'Voir moins';

  @override
  String get shareResults => 'Partager les résultats';

  @override
  String get verdictTrue => 'VRAI';

  @override
  String get verdictMostlyTrue => 'PLUTÔT VRAI';

  @override
  String get verdictMixed => 'MIXTE';

  @override
  String get verdictMostlyFalse => 'PLUTÔT FAUX';

  @override
  String get verdictFalse => 'FAUX';

  @override
  String get verdictUnverifiable => 'NON VÉRIFIABLE';

  @override
  String get themeSelection => 'Sélection du thème';

  @override
  String get themeDescription => 'Choisissez l\'apparence de l\'application';

  @override
  String get systemThemeDescription => 'Utiliser le thème du système';

  @override
  String get deepfakeAlertTitle => 'Alerte Deepfake';

  @override
  String get deepfakeAlertMessage =>
      'Deepfake : ne croyez pas aux informations non vérifiées.';

  @override
  String get enableSocialVigil => 'Activer la Vigie Sociale';

  @override
  String get socialVigilDescription =>
      'Lorsque activée, Truth AI vous rappelle discrètement lors de l’utilisation des réseaux sociaux sélectionnés.';
}
