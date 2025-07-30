// lib/core/routing/app_router.dart
// Navigation and routing configuration for the app

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:azhari_template/features/home/presentation/pages/home_page.dart';
import 'package:azhari_template/features/profile/presentation/pages/profile_page.dart';
import 'package:azhari_template/features/settings/presentation/pages/settings_page.dart';
import 'package:azhari_template/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  // Router configuration for app navigation
  static final GoRouter router = GoRouter(
    // Set initial route to splash
    initialLocation: '/splash',
    
    // Define all app routes
    routes: [
      // Splash screen route
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Home screen route
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      
      // Profile screen route
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      
      // Settings screen route
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    
    // Handle navigation errors
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
  
  // Navigation helper methods
  static void goToHome(BuildContext context) => context.go('/home');
  static void goToProfile(BuildContext context) => context.go('/profile');
  static void goToSettings(BuildContext context) => context.go('/settings');
  static void goBack(BuildContext context) => context.pop();
}