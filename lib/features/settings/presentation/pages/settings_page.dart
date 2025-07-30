// lib/features/settings/presentation/pages/settings_page.dart
// Comprehensive settings page with theme and language options

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azhari_template/core/theme/bloc/theme_bloc.dart';
import 'package:azhari_template/core/language/bloc/language_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Card(
            child: Column(
              children: [
                // Theme setting
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    String themeText;
                    switch (state.themeMode) {
                      case ThemeMode.light:
                        themeText = l10n.light;
                        break;
                      case ThemeMode.dark:
                        themeText = l10n.dark;
                        break;
                      case ThemeMode.system:
                        themeText = l10n.system;
                        break;
                    }

                    return ListTile(
                      leading: const Icon(Icons.palette),
                      title: Text(l10n.theme),
                      subtitle: Text(themeText),
                      onTap: () => _showThemeDialog(context, l10n),
                    );
                  },
                ),
                
                const Divider(height: 1),
                
                // Language setting
                BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                    String languageText;
                    switch (state.locale.languageCode) {
                      case 'ms':
                        languageText = l10n.malay;
                        break;
                      case 'en':
                      default:
                        languageText = l10n.english;
                        break;
                    }

                    return ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(l10n.language),
                      subtitle: Text(languageText),
                      onTap: () => _showLanguageDialog(context, l10n),
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Other Settings Section
          Text(
            'Other',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Notification toggle logic
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // About page logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Show theme selection dialog
  void _showThemeDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(context, ThemeMode.system, l10n.system, l10n),
            _buildThemeOption(context, ThemeMode.light, l10n.light, l10n),
            _buildThemeOption(context, ThemeMode.dark, l10n.dark, l10n),
          ],
        ),
      ),
    );
  }

  // Build theme option tile
  Widget _buildThemeOption(
    BuildContext context,
    ThemeMode themeMode,
    String title,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return RadioListTile<ThemeMode>(
          title: Text(title),
          value: themeMode,
          groupValue: state.themeMode,
          onChanged: (value) {
            if (value != null) {
              context.read<ThemeBloc>().add(ThemeChanged(value));
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  // Show language selection dialog
  void _showLanguageDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, const Locale('en'), l10n.english),
            _buildLanguageOption(context, const Locale('ms'), l10n.malay),
          ],
        ),
      ),
    );
  }

  // Build language option tile
  Widget _buildLanguageOption(
    BuildContext context,
    Locale locale,
    String title,
  ) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return RadioListTile<Locale>(
          title: Text(title),
          value: locale,
          groupValue: state.locale,
          onChanged: (value) {
            if (value != null) {
              context.read<LanguageBloc>().add(LanguageChanged(value));
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }
}