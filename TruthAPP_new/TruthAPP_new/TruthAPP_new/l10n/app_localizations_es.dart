// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'Verificación de Texto';

  @override
  String get imageForensics => 'Forensia de Imagen';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'Analiza un texto, artículo o declaración';

  @override
  String get welcomeForensics =>
      'Bienvenido al modo Forensics. Sube una imagen para analizar su origen, detectar manipulaciones y verificar su contexto. La verdad está en los detalles.';

  @override
  String get welcomeDaily =>
      'Truth Daily es tu vigilancia de información en tiempo real. Ingresa un tema, palabra clave o nombre de evento para obtener un análisis factual e imparcial de las últimas noticias.';

  @override
  String get uploadImage => 'Haz clic o arrastra para subir una imagen';

  @override
  String get newAnalysis => 'Nuevo Análisis';

  @override
  String get analysisInProgress => 'Análisis en curso...';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get systemTheme => 'Tema del Sistema';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma del Sistema';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'Ver más';

  @override
  String get seeLess => 'Ver menos';

  @override
  String get shareResults => 'Compartir resultados';

  @override
  String get verdictTrue => 'VERDADERO';

  @override
  String get verdictMostlyTrue => 'MAYORMENTE VERDADERO';

  @override
  String get verdictMixed => 'MIXTO';

  @override
  String get verdictMostlyFalse => 'MAYORMENTE FALSO';

  @override
  String get verdictFalse => 'FALSO';

  @override
  String get verdictUnverifiable => 'NO VERIFICABLE';

  @override
  String get themeSelection => 'Selección de tema';

  @override
  String get themeDescription => 'Elija la apariencia de la aplicación';

  @override
  String get systemThemeDescription => 'Usar tema del sistema';

  @override
  String get deepfakeAlertTitle => 'Alerta de deepfake';

  @override
  String get deepfakeAlertMessage =>
      'Deepfake: no creas en información no verificada.';

  @override
  String get enableSocialVigil => 'Activar la Vigilancia Social';

  @override
  String get socialVigilDescription =>
      'Cuando está activada, Truth AI te recuerda discretamente al usar las redes sociales seleccionadas.';
}
