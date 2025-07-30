// lib/core/language/bloc/language_bloc.dart
// BLoC for managing app language/locale state

import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Language events
abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

// Event to change language
class LanguageChanged extends LanguageEvent {
  final Locale locale;

  const LanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}

// Event to load saved language
class LanguageLoaded extends LanguageEvent {}

// Language state
class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState({required this.locale});

  // Initial state with English locale
  factory LanguageState.initial() {
    return const LanguageState(locale: Locale('en'));
  }

  // Copy method for state updates
  LanguageState copyWith({Locale? locale}) {
    return LanguageState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [locale];
}

// Language BLoC implementation
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final SharedPreferences _prefs;
  static const String _languageKey = 'language_code';

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('ms'), // Malay
  ];

  LanguageBloc(this._prefs) : super(LanguageState.initial()) {
    // Register event handlers
    on<LanguageLoaded>(_onLanguageLoaded);
    on<LanguageChanged>(_onLanguageChanged);
  }

  // Load saved language from preferences
  Future<void> _onLanguageLoaded(
    LanguageLoaded event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      final savedLanguage = _prefs.getString(_languageKey);
      
      if (savedLanguage != null) {
        final locale = Locale(savedLanguage);
        
        // Check if locale is supported
        if (supportedLocales.contains(locale)) {
          emit(state.copyWith(locale: locale));
        }
      }
    } catch (e) {
      // If error occurs, keep current state
      emit(state);
    }
  }

  // Handle language change
  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      // Save new language to preferences
      await _prefs.setString(_languageKey, event.locale.languageCode);
      
      // Emit new state
      emit(state.copyWith(locale: event.locale));
    } catch (e) {
      // If saving fails, still emit the new state
      emit(state.copyWith(locale: event.locale));
    }
  }
}