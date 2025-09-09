// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SAr extends S {
  SAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'التحقق من النص';

  @override
  String get imageForensics => 'الطب الشرعي للصورة';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'حلل نصًا أو مقالًا أو بيانًا';

  @override
  String get welcomeForensics =>
      'مرحبًا بك في وضع الطب الشرعي. قم بتحميل صورة لتحليل مصدرها، واكتشاف التلاعب، والتحقق من سياقها. الحقيقة في التفاصيل.';

  @override
  String get welcomeDaily =>
      'Truth Daily هو مراقبة المعلومات في الوقت الفعلي الخاص بك. أدخل موضوعًا أو كلمة رئيسية أو اسم حدث للحصول على تحليل واقعي وغير متحيز لأحدث الأخبار.';

  @override
  String get uploadImage => 'انقر أو اسحب لتحميل الصورة';

  @override
  String get newAnalysis => 'تحليل جديد';

  @override
  String get analysisInProgress => 'جاري التحليل...';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get systemTheme => 'سمة النظام';

  @override
  String get language => 'اللغة';

  @override
  String get systemLanguage => 'لغة النظام';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'رؤية المزيد';

  @override
  String get seeLess => 'رؤية أقل';

  @override
  String get shareResults => 'مشاركة النتائج';

  @override
  String get verdictTrue => 'صحيح';

  @override
  String get verdictMostlyTrue => 'غالبًا صحيح';

  @override
  String get verdictMixed => 'مختلط';

  @override
  String get verdictMostlyFalse => 'غالبًا خاطئ';

  @override
  String get verdictFalse => 'خاطئ';

  @override
  String get verdictUnverifiable => 'غير قابل للتحقق';

  @override
  String get themeSelection => 'اختيار السمة';

  @override
  String get themeDescription => 'اختر مظهر التطبيق';

  @override
  String get systemThemeDescription => 'استخدام سمة النظام';
}
