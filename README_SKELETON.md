# E-Kira App Skeleton Template

A comprehensive Flutter skeleton template with routing, internationalization, BLoC state management, theming, and dependency injection.

## 🚀 Features

### ✅ Completed Setup
1. **Routing & Navigation** - Go Router with named routes and error handling
2. **Internationalization** - English and Malay language support (easy to add more)
3. **Dependency Injection** - GetIt service locator pattern
4. **BLoC State Management** - Theme and Language BLoCs with persistent storage
5. **Flexible Theming** - Light/Dark/System theme modes with custom colors
6. **Custom Fonts** - Poppins font family configuration

### 📁 Project Structure

```
lib/
├── core/
│   ├── language/
│   │   └── bloc/           # Language management BLoC
│   ├── routing/
│   │   ├── app_router.dart # Main routing configuration
│   │   └── route_names.dart # Route constants
│   ├── secret/
│   │   └── get_pref.dart   # Preferences utilities
│   └── theme/
│       ├── bloc/           # Theme management BLoC
│       ├── app_colors.dart # Color constants
│       ├── app_text_styles.dart # Text style definitions
│       └── app_theme.dart  # Theme configuration
├── features/
│   ├── home/               # Home feature module
│   ├── profile/            # Profile feature module
│   ├── settings/           # Settings feature module
│   └── splash/             # Splash screen module
├── l10n/
│   ├── arb/               # Translation files
│   │   ├── app_en.arb     # English translations
│   │   └── app_ms.arb     # Malay translations
│   └── generated/         # Generated localization files (auto-generated)
├── init_dependencies.dart # Dependency injection setup
└── main.dart              # App entry point
```

## 🔧 Setup Instructions

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Generate Localization Files
```bash
flutter gen-l10n
```

### 3. Download Fonts
Download Poppins fonts from [Google Fonts](https://fonts.google.com/specimen/Poppins) and place them in `assets/fonts/`:

- `Poppins-Regular.ttf`
- `Poppins-Medium.ttf`
- `Poppins-SemiBold.ttf`
- `Poppins-Bold.ttf`

### 4. Run the App
```bash
flutter run
```

## 📚 How to Use

### 🌐 Adding New Languages

1. Create new ARB file in `lib/l10n/arb/`:
```bash
# Example for French
touch lib/l10n/arb/app_fr.arb
```

2. Add translations following the same structure as `app_en.arb`

3. Update `supportedLocales` in `main.dart`:
```dart
supportedLocales: const [
  Locale('en'), // English
  Locale('ms'), // Malay
  Locale('fr'), // French
],
```

4. Update `LanguageBloc` to include new locale in `supportedLocales`

### 🎨 Customizing Themes

#### Colors
Edit `lib/core/theme/app_colors.dart` to change color scheme:
```dart
static const Color primary = Color(0xFF6750A4); // Change primary color
```

#### Text Styles
Modify `lib/core/theme/app_text_styles.dart` for typography:
```dart
static const String fontFamily = 'YourFont'; // Change font family
```

#### Theme Configuration
Update `lib/core/theme/app_theme.dart` for component themes:
```dart
// Customize button styles, card themes, etc.
```

### 🧭 Adding New Routes

1. Add route constants in `lib/core/routing/route_names.dart`:
```dart
static const String newPage = 'newPage';
static const String newPagePath = '/new-page';
```

2. Update `lib/core/routing/app_router.dart`:
```dart
GoRoute(
  path: RoutePaths.newPage,
  name: RouteNames.newPage,
  builder: (context, state) => const NewPage(),
),
```

3. Add navigation helper:
```dart
static void goToNewPage(BuildContext context) => context.go(RoutePaths.newPage);
```

### 🏗️ Creating New Features

Follow the feature-based architecture:

```
lib/features/your_feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

### 💉 Dependency Injection

Add new services in `lib/init_dependencies.main.dart`:

```dart
// Register repositories
serviceLocator.registerLazySingleton<YourRepository>(
  () => YourRepositoryImpl(),
);

// Register use cases
serviceLocator.registerLazySingleton<YourUseCase>(
  () => YourUseCase(serviceLocator()),
);

// Register BLoCs
serviceLocator.registerFactory<YourBloc>(
  () => YourBloc(serviceLocator()),
);
```

## 🎯 Key Components

### State Management
- **ThemeBloc**: Manages app theme (light/dark/system)
- **LanguageBloc**: Manages app language/locale
- **SplashBloc**: Handles splash screen logic

### Navigation
- Uses Go Router for declarative routing
- Named routes with error handling
- Helper methods for navigation

### Theming
- Material Design 3 compliant
- Separate light and dark themes
- Custom color scheme and typography

### Internationalization
- ARB file format for translations
- Easy to add new languages
- Automatic localization generation

## 🚀 Next Steps

After setting up the skeleton:

1. **Add your business logic** in the features folder
2. **Create repositories and use cases** following clean architecture
3. **Add more BLoCs** for feature-specific state management
4. **Implement API integration** using HTTP client
5. **Add local storage** with SharedPreferences or Hive
6. **Set up testing** (unit, widget, integration tests)

## 📝 Comments and Best Practices

- All code includes clear English comments
- Follows PSR-12 equivalent for Dart (dart format)
- Clean architecture principles
- Copy-paste ready code snippets
- Step-by-step implementation approach

## 🔧 Troubleshooting

### Localization Issues
If localization files aren't generated:
```bash
flutter clean
flutter pub get
flutter gen-l10n
```

### Font Issues
Make sure font files are in the correct directory and names match `pubspec.yaml`

### Navigation Issues
Check route names and paths match in `route_names.dart` and `app_router.dart`

---

**Ready to build amazing Flutter apps! 🎉**