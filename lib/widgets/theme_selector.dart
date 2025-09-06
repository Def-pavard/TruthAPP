// lib/widgets/theme_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truth_ai/providers/theme_provider.dart';
import 'package:truth_ai/generated/l10n.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final s = S.of(context);

    return AlertDialog(
      title: Text(s.systemTheme),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Option thème système
          ListTile(
            leading: const Icon(Icons.auto_awesome),
            title: Text(s.systemTheme),
            trailing: themeProvider.useSystemTheme
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              themeProvider.setUseSystemTheme(true);
              Navigator.pop(context);
            },
          ),
          
          const Divider(),
          
          // Option thème clair
          ListTile(
            leading: const Icon(Icons.wb_sunny),
            title: Text(s.lightMode),
            trailing: !themeProvider.useSystemTheme && !themeProvider.isDarkMode
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              themeProvider.setDarkMode(false);
              Navigator.pop(context);
            },
          ),
          
          // Option thème sombre
          ListTile(
            leading: const Icon(Icons.nightlight_round),
            title: Text(s.darkMode),
            trailing: !themeProvider.useSystemTheme && themeProvider.isDarkMode
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              themeProvider.setDarkMode(true);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}