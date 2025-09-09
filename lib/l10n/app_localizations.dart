import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('he'),
    Locale('ja'),
    Locale('pl'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Truth AI Verifier'**
  String get appTitle;

  /// No description provided for @textVerification.
  ///
  /// In en, this message translates to:
  /// **'Text Verification'**
  String get textVerification;

  /// No description provided for @imageForensics.
  ///
  /// In en, this message translates to:
  /// **'Image Forensics'**
  String get imageForensics;

  /// No description provided for @truthDaily.
  ///
  /// In en, this message translates to:
  /// **'Truth Daily'**
  String get truthDaily;

  /// No description provided for @analyzeText.
  ///
  /// In en, this message translates to:
  /// **'Analyze a text, article or statement'**
  String get analyzeText;

  /// No description provided for @welcomeForensics.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Forensics mode. Upload an image to analyze its origin, detect manipulations and verify its context. Truth is in the details.'**
  String get welcomeForensics;

  /// No description provided for @welcomeDaily.
  ///
  /// In en, this message translates to:
  /// **'Truth Daily is your real-time information watch. Enter a topic, keyword or event name to get factual and impartial analysis of the latest news.'**
  String get welcomeDaily;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Click or drag to upload an image'**
  String get uploadImage;

  /// No description provided for @newAnalysis.
  ///
  /// In en, this message translates to:
  /// **'new analysis'**
  String get newAnalysis;

  /// No description provided for @analysisInProgress.
  ///
  /// In en, this message translates to:
  /// **'Analysis in progress...'**
  String get analysisInProgress;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get systemTheme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System Language'**
  String get systemLanguage;

  /// No description provided for @highConfidence.
  ///
  /// In en, this message translates to:
  /// **'high confidence'**
  String get highConfidence;

  /// No description provided for @mediumConfidence.
  ///
  /// In en, this message translates to:
  /// **'medium confidence'**
  String get mediumConfidence;

  /// No description provided for @lowConfidence.
  ///
  /// In en, this message translates to:
  /// **'low confidence'**
  String get lowConfidence;

  /// No description provided for @veryLowConfidence.
  ///
  /// In en, this message translates to:
  /// **'very low confidence'**
  String get veryLowConfidence;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get seeMore;

  /// No description provided for @seeLess.
  ///
  /// In en, this message translates to:
  /// **'See less'**
  String get seeLess;

  /// No description provided for @shareResults.
  ///
  /// In en, this message translates to:
  /// **'Share results'**
  String get shareResults;

  /// No description provided for @verdictTrue.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get verdictTrue;

  /// No description provided for @verdictMostlyTrue.
  ///
  /// In en, this message translates to:
  /// **'MOSTLY TRUE'**
  String get verdictMostlyTrue;

  /// No description provided for @verdictMixed.
  ///
  /// In en, this message translates to:
  /// **'MIXED'**
  String get verdictMixed;

  /// No description provided for @verdictMostlyFalse.
  ///
  /// In en, this message translates to:
  /// **'MOSTLY FALSE'**
  String get verdictMostlyFalse;

  /// No description provided for @verdictFalse.
  ///
  /// In en, this message translates to:
  /// **'FALSE'**
  String get verdictFalse;

  /// No description provided for @verdictUnverifiable.
  ///
  /// In en, this message translates to:
  /// **'unverifiable'**
  String get verdictUnverifiable;

  /// No description provided for @themeSelection.
  ///
  /// In en, this message translates to:
  /// **'Theme selection'**
  String get themeSelection;

  /// No description provided for @themeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the appearance of the application'**
  String get themeDescription;

  /// No description provided for @systemThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Use system theme'**
  String get systemThemeDescription;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'he',
        'ja',
        'pl',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'de':
      return SDe();
    case 'en':
      return SEn();
    case 'es':
      return SEs();
    case 'fr':
      return SFr();
    case 'he':
      return SHe();
    case 'ja':
      return SJa();
    case 'pl':
      return SPl();
    case 'ru':
      return SRu();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
