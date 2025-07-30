// lib/features/splash/presentation/bloc/splash_bloc.dart
// BLoC for splash screen logic

import 'package:azhari_template/features/splash/presentation/bloc/splash_event.dart';
import 'package:azhari_template/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Splash BLoC implementation
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    // Register event handlers
    on<SplashStarted>(_onSplashStarted);
  }

  // Handle splash start
  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    // Emit loading state
    emit(SplashLoading());

    // Simulate loading time (you can add actual initialization here)
    await Future.delayed(const Duration(seconds: 2));

    // Complete splash
    emit(SplashCompleted());
  }
}