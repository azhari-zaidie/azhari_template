// // test/widget_test.dart
// // Basic Flutter widget test for E-Kira app

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:azhari_template/init_dependencies.dart';
// import 'package:azhari_template/main.dart';

// void main() {
//   // Setup dependencies for testing
//   setUpAll(() async {
//     await initDependencies();
//   });

//   testWidgets('App smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame
//     await tester.pumpWidget(const EKiraApp());
    
//     // Wait for splash screen
//     await tester.pump();
    
//     // Verify that splash screen loads
//     expect(find.text('E-Kira'), findsOneWidget);
//     expect(find.text('Your Shopping Assistant'), findsOneWidget);
    
//     // Wait for splash timer to complete
//     await tester.pump(const Duration(seconds: 3));
    
//     // The app should navigate to home page after splash
//     // (Note: This test might need adjustment based on actual navigation timing)
//   });
  
//   testWidgets('Theme switching test', (WidgetTester tester) async {
//     // Test that app can switch themes without crashing
//     await tester.pumpWidget(const EKiraApp());
//     await tester.pump();
    
//     // The app should render without throwing exceptions
//     expect(find.byType(MaterialApp), findsOneWidget);
//   });
// }
