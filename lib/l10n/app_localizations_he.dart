// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class SHe extends S {
  SHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'אימות טקסט';

  @override
  String get imageForensics => 'זיהוי פלילי של תמונות';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'נַאֲלֵם טקסט, מאמר או הצהרה';

  @override
  String get welcomeForensics =>
      'ברוך הבא למצב Forensics. העלה תמונה כדי לנתח את מקורה, לזהות מניפולציות ולאמת את ההקשר שלה. האמת נמצאת בפרטים.';

  @override
  String get welcomeDaily =>
      'Truth Daily הוא מערכת המעקב אחר מידע בזמן אמת שלך. הזן נושא, מילת מפתח או שם אירוע כדי לקבל ניתוח עובדתי ולא מוטה של החדשות האחרונות.';

  @override
  String get uploadImage => 'לחץ או גרור כדי להעלות תמונה';

  @override
  String get newAnalysis => 'ניתוח חדש';

  @override
  String get analysisInProgress => 'ניתוח מתבצע...';

  @override
  String get darkMode => 'מצב כהה';

  @override
  String get lightMode => 'מצב בהיר';

  @override
  String get systemTheme => 'ערכת נושא של המערכת';

  @override
  String get language => 'שפה';

  @override
  String get systemLanguage => 'שפת מערכת';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'ראה עוד';

  @override
  String get seeLess => 'ראה פחות';

  @override
  String get shareResults => 'שתף תוצאות';

  @override
  String get verdictTrue => 'נָכוֹן';

  @override
  String get verdictMostlyTrue => 'ברובו נכון';

  @override
  String get verdictMixed => 'מָעוֹרָב';

  @override
  String get verdictMostlyFalse => 'ברובו שקרי';

  @override
  String get verdictFalse => 'שֶׁקֶר';

  @override
  String get verdictUnverifiable => 'לא ניתן לאימות';

  @override
  String get themeSelection => 'בחירת ערכת נושא';

  @override
  String get themeDescription => 'בחר את המראה של היישום';

  @override
  String get systemThemeDescription => 'השתמש בערכת הנושא של המערכת';
}
