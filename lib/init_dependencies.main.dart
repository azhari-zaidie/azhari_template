part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Register SharedPreferences
  serviceLocator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  
  // Register BLoCs
  serviceLocator.registerFactory<ThemeBloc>(
    () => ThemeBloc(serviceLocator<SharedPreferences>()),
  );
  
  serviceLocator.registerFactory<LanguageBloc>(
    () => LanguageBloc(serviceLocator<SharedPreferences>()),
  );
  
  // Register repositories (add your repositories here)
  // Example: serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  
  // Register use cases (add your use cases here)  
  // Example: serviceLocator.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(serviceLocator()));
}

