// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class SJa extends S {
  SJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'テキスト検証';

  @override
  String get imageForensics => '画像フォレンジック';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'テキスト、記事、または声明を分析する';

  @override
  String get welcomeForensics =>
      'フォレンジックモードへようこそ。画像をアップロードして、その出所を分析し、改ざんを検出し、文脈を検証します。真実は細部に宿ります。';

  @override
  String get welcomeDaily =>
      'Truth Dailyは、リアルタイムの情報監視です。トピック、キーワード、またはイベント名を入力して、最新ニュースの事実に基づいた偏りのない分析を取得します。';

  @override
  String get uploadImage => 'クリックまたはドラッグして画像をアップロード';

  @override
  String get newAnalysis => '新しい分析';

  @override
  String get analysisInProgress => '分析中...';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get systemTheme => 'システムテーマ';

  @override
  String get language => '言語';

  @override
  String get systemLanguage => 'システム言語';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'もっと見る';

  @override
  String get seeLess => '折りたたむ';

  @override
  String get shareResults => '結果を共有';

  @override
  String get verdictTrue => '真実';

  @override
  String get verdictMostlyTrue => 'ほぼ真実';

  @override
  String get verdictMixed => '混合';

  @override
  String get verdictMostlyFalse => 'ほぼ虚偽';

  @override
  String get verdictFalse => '虚偽';

  @override
  String get verdictUnverifiable => '検証不能';

  @override
  String get themeSelection => 'テーマ選択';

  @override
  String get themeDescription => 'アプリの外観を選択';

  @override
  String get systemThemeDescription => 'システムテーマを使用';
}
