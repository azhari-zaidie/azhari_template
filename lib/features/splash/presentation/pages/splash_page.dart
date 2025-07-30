// lib/features/splash/presentation/pages/splash_page.dart
// Splash screen with app branding and loading

import 'package:azhari_template/core/routing/app_router.dart';
import 'package:azhari_template/features/splash/presentation/bloc/splash_event.dart';
import 'package:azhari_template/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azhari_template/features/splash/presentation/bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        // Navigate to home when splash completes
        if (state is SplashCompleted) {
          // context.go(RoutePaths.home);
          AppRouter.goToHome(context);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo or icon
              Icon(
                Icons.shopping_cart,
                size: 80,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              
              const SizedBox(height: 24),
              
              // App title
              Text(
                'Azhari Template',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // App subtitle
              Text(
                'Your Shopping Assistant',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.8),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Loading indicator
              BlocBuilder<SplashBloc, SplashState>(
                builder: (context, state) {
                  if (state is SplashLoading) {
                    return CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}