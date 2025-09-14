// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => '文本验证';

  @override
  String get imageForensics => '图像取证';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => '分析文本、文章或声明';

  @override
  String get welcomeForensics => '欢迎使用取证模式。上传图像以分析其来源、检测操纵并验证其上下文。真相就在细节中。';

  @override
  String get welcomeDaily =>
      'Truth Daily 是您的实时信息监控。输入主题、关键词或事件名称，以获取最新新闻的事实性和无偏见分析。';

  @override
  String get uploadImage => '点击或拖拽上传图片';

  @override
  String get newAnalysis => '新分析';

  @override
  String get analysisInProgress => '分析中...';

  @override
  String get darkMode => '深色模式';

  @override
  String get lightMode => '浅色模式';

  @override
  String get systemTheme => '系统主题';

  @override
  String get language => '语言';

  @override
  String get systemLanguage => '系统语言';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => '查看更多';

  @override
  String get seeLess => '收起';

  @override
  String get shareResults => '分享结果';

  @override
  String get verdictTrue => '真实';

  @override
  String get verdictMostlyTrue => '基本真实';

  @override
  String get verdictMixed => '混合';

  @override
  String get verdictMostlyFalse => '基本虚假';

  @override
  String get verdictFalse => '虚假';

  @override
  String get verdictUnverifiable => '无法验证';

  @override
  String get themeSelection => '主题选择';

  @override
  String get themeDescription => '选择应用程序的外观';

  @override
  String get systemThemeDescription => '使用系统主题';

  @override
  String get deepfakeAlertTitle => '深度伪造警告';

  @override
  String get deepfakeAlertMessage => '深度伪造：不要相信未经验证的信息。';

  @override
  String get enableSocialVigil => '启用社交守护';

  @override
  String get socialVigilDescription => '启用后，Truth AI 会在您使用所选社交媒体时悄悄提醒您。';
}
