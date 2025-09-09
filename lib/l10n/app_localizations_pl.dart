// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class SPl extends S {
  SPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Truth AI Verifier';

  @override
  String get textVerification => 'Weryfikacja tekstu';

  @override
  String get imageForensics => 'Kryminalistyka obrazu';

  @override
  String get truthDaily => 'Truth Daily';

  @override
  String get analyzeText => 'Przeanalizuj tekst, artykuł lub oświadczenie';

  @override
  String get welcomeForensics =>
      'Witamy w trybie Forensics. Prześlij obraz, aby przeanalizować jego pochodzenie, wykryć manipulacje i zweryfikować kontekst. Prawda kryje się w szczegółach.';

  @override
  String get welcomeDaily =>
      'Truth Daily to Twój monitoring informacji w czasie rzeczywistym. Wprowadź temat, słowo kluczowe lub nazwę wydarzenia, aby uzyskać rzeczową i bezstronną analizę najnowszych wiadomości.';

  @override
  String get uploadImage => 'Kliknij lub przeciągnij, aby przesłać obraz';

  @override
  String get newAnalysis => 'Nowa analiza';

  @override
  String get analysisInProgress => 'Analiza w toku...';

  @override
  String get darkMode => 'Tryb ciemny';

  @override
  String get lightMode => 'Tryb jasny';

  @override
  String get systemTheme => 'Motyw systemowy';

  @override
  String get language => 'Język';

  @override
  String get systemLanguage => 'Język systemowy';

  @override
  String get highConfidence => 'high confidence';

  @override
  String get mediumConfidence => 'medium confidence';

  @override
  String get lowConfidence => 'low confidence';

  @override
  String get veryLowConfidence => 'very low confidence';

  @override
  String get seeMore => 'Zobacz więcej';

  @override
  String get seeLess => 'Zobacz mniej';

  @override
  String get shareResults => 'Udostępnij wyniki';

  @override
  String get verdictTrue => 'PRAWDA';

  @override
  String get verdictMostlyTrue => 'W WIĘKSZOŚCI PRAWDA';

  @override
  String get verdictMixed => 'MIESZANE';

  @override
  String get verdictMostlyFalse => 'W WIĘKSZOŚCI FAŁSZ';

  @override
  String get verdictFalse => 'FAŁSZ';

  @override
  String get verdictUnverifiable => 'NIEWERYFIKOWALNE';

  @override
  String get themeSelection => 'Wybór motywu';

  @override
  String get themeDescription => 'Wybierz wygląd aplikacji';

  @override
  String get systemThemeDescription => 'Użyj motywu systemowego';
}
