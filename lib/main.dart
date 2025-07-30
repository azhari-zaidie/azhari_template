// lib/main.dart
// Main entry point for the E-Kira app

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:azhari_template/init_dependencies.dart';
import 'package:azhari_template/core/routing/app_router.dart';
import 'package:azhari_template/core/theme/app_theme.dart';
import 'package:azhari_template/core/theme/bloc/theme_bloc.dart';
import 'package:azhari_template/core/language/bloc/language_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await initDependencies();

  // Run the app
  runApp(const AzhariTemplateApp());
}

class AzhariTemplateApp extends StatelessWidget {
  const AzhariTemplateApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide BLoCs to the entire app
    return MultiBlocProvider(
      providers: [
        // Theme BLoC provider
        BlocProvider<ThemeBloc>(
          create: (context) => serviceLocator<ThemeBloc>()..add(ThemeLoaded()),
        ),
        
        // Language BLoC provider
        BlocProvider<LanguageBloc>(
          create: (context) => serviceLocator<LanguageBloc>()..add(LanguageLoaded()),
        ),
      ],
      child: const AzhariTemplateAppView(),
    );
  }
}

class AzhariTemplateAppView extends StatelessWidget {
  const AzhariTemplateAppView({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to theme and language changes
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            return MaterialApp.router(
              // App title
              title: 'Azhari Template',
              
              // Debug banner
              debugShowCheckedModeBanner: false,
              
              // Theme configuration
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              
              // Localization configuration
              locale: languageState.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('ms'), // Malay
              ],
              
              // Router configuration
              routerConfig: AppRouter.router,
            );
          },
        );
      },
    );
  }
}
