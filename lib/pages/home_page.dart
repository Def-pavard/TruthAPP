// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truth_ai/providers/theme_provider.dart';
import 'package:truth_ai/providers/language_provider.dart';
import 'package:truth_ai/pages/text_page.dart';
import 'package:truth_ai/pages/forensics_page.dart';
import 'package:truth_ai/pages/daily_page.dart';
import 'package:truth_ai/widgets/animated_background.dart';
import 'package:truth_ai/widgets/theme_selector.dart';
import 'package:truth_ai/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Initialiser les providers
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    
    themeProvider.updateFromSystem();
    languageProvider.updateFromSystem();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.updateFromSystem();
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    languageProvider.updateFromSystem();
    super.didChangeLocales(locales);
  }

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ThemeSelector(),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    // À implémenter: Sélecteur de langue
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sélecteur de langue à implémenter')),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, bool isActive) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: isActive 
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final s = S.of(context);

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            s.appTitle,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          actions: [
            // Bouton de sélection de langue
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () => _showLanguageSelector(context),
              tooltip: s.language,
            ),
            // Bouton de sélection de thème
            IconButton(
              icon: themeProvider.useSystemTheme
                  ? const Icon(Icons.auto_awesome)
                  : Icon(themeProvider.isDarkMode 
                      ? Icons.nightlight_round 
                      : Icons.wb_sunny),
              onPressed: () => _showThemeSelector(context),
              tooltip: s.systemTheme,
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: const [
            TextPage(),
            ForensicsPage(),
            DailyPage(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentPage,
              onTap: (int index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[900]!.withOpacity(0.9)
                  : Colors.white.withOpacity(0.9),
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              items: [
                _buildNavItem(Icons.text_fields, s.textVerification, _currentPage == 0),
                _buildNavItem(Icons.image, s.imageForensics, _currentPage == 1),
                _buildNavItem(Icons.newspaper, s.truthDaily, _currentPage == 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}