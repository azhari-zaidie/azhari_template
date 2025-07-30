// lib/core/theme/bloc/theme_bloc.dart
// BLoC for managing app theme state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

// Event to change theme mode
class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;

  const ThemeChanged(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

// Event to load saved theme
class ThemeLoaded extends ThemeEvent {}

// Theme state
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  // Initial state with system theme
  factory ThemeState.initial() {
    return const ThemeState(themeMode: ThemeMode.system);
  }

  // Copy method for state updates
  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [themeMode];
}

// Theme BLoC implementation
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';

  ThemeBloc(this._prefs) : super(ThemeState.initial()) {
    // Register event handlers
    on<ThemeLoaded>(_onThemeLoaded);
    on<ThemeChanged>(_onThemeChanged);
  }

  // Load saved theme from preferences
  Future<void> _onThemeLoaded(
    ThemeLoaded event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final savedTheme = _prefs.getString(_themeKey);
      ThemeMode themeMode;

      // Convert saved string to ThemeMode
      switch (savedTheme) {
        case 'light':
          themeMode = ThemeMode.light;
          break;
        case 'dark':
          themeMode = ThemeMode.dark;
          break;
        case 'system':
        default:
          themeMode = ThemeMode.system;
          break;
      }

      emit(state.copyWith(themeMode: themeMode));
    } catch (e) {
      // If error occurs, keep current state
      emit(state);
    }
  }

  // Handle theme change
  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      // Save new theme to preferences
      String themeString;
      switch (event.themeMode) {
        case ThemeMode.light:
          themeString = 'light';
          break;
        case ThemeMode.dark:
          themeString = 'dark';
          break;
        case ThemeMode.system:
          themeString = 'system';
          break;
      }

      await _prefs.setString(_themeKey, themeString);
      
      // Emit new state
      emit(state.copyWith(themeMode: event.themeMode));
    } catch (e) {
      // If saving fails, still emit the new state
      emit(state.copyWith(themeMode: event.themeMode));
    }
  }
}