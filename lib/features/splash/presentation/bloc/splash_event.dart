// Splash events
import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

// Event to start splash timer
class SplashStarted extends SplashEvent {}

// Splash states
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}
