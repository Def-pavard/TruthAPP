// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:truth_ai/providers/theme_provider.dart';
import 'package:truth_ai/providers/language_provider.dart';
import 'package:truth_ai/pages/splash_screen.dart';
import 'package:truth_ai/generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: 'Truth AI Verifier',
            theme: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF2ECC71),
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: const Color(0xFFF5F5DC),
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
                bodyMedium: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                titleTextStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: const Color(0xFF3EB489),
              scaffoldBackgroundColor: Colors.black,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: const Color(0xFF1A1A1A),
              ),
              textTheme: TextTheme(
                bodyLarge: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
                bodyMedium: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: themeProvider.useSystemTheme
                ? ThemeMode.system
                : (themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light),
            locale: languageProvider.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'), // Anglais
              Locale('fr', 'FR'), // Français
              Locale('es', 'ES'), // Espagnol
              Locale('de', 'DE'), // Allemand
              Locale('ru', 'RU'), // Russe
              Locale('zh', 'CN'), // Mandarin
              Locale('ja', 'JP'), // Japonais
              Locale('he', 'IL'), // Hébreu
              Locale('pl', 'PL'), // Polonais
              Locale('ar', 'SA'), // Arabe
              Locale('ko', 'KR'), // Coréen
            ],
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
