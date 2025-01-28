import 'package:cleancode_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:cleancode_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/core/theme/theme_manager.dart';
import 'package:cleancode_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:cleancode_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleancode_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:cleancode_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/app.dart';
import 'package:cleancode_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:cleancode_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:cleancode_app/features/products/domain/repositories/product_repository.dart';
import 'package:cleancode_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:cleancode_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:cleancode_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:cleancode_app/features/users/data/repositories/user_repository_impl.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';
import 'package:cleancode_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuración de dependencias con GetIt
  final dioClient = DioClient();
  getIt.registerSingleton<DioClient>(dioClient);

  final authRemoteDataSource = AuthRemoteDataSourceImpl(dioClient: dioClient);
  getIt.registerSingleton<AuthRemoteDataSource>(authRemoteDataSource);

  final authRepository =
      AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
  getIt.registerSingleton<AuthRepository>(authRepository);

  final loginUseCase = LoginUseCase(repository: authRepository);
  getIt.registerSingleton<LoginUseCase>(loginUseCase);

  final logoutUseCase = LogoutUseCase(repository: authRepository);
  getIt.registerSingleton<LogoutUseCase>(logoutUseCase);

  final registerUseCase = RegisterUseCase(repository: authRepository);
  getIt.registerSingleton<RegisterUseCase>(registerUseCase);

  final productRemoteDataSource =
      ProductRemoteDataSourceImpl(dioClient: dioClient);
  getIt.registerSingleton<ProductRemoteDataSource>(productRemoteDataSource);

  final productRepository =
      ProductRepositoryImpl(remoteDataSource: productRemoteDataSource);
  getIt.registerSingleton<ProductRepository>(productRepository);

  final getProductsUseCase = GetProductsUseCase(repository: productRepository);
  getIt.registerSingleton<GetProductsUseCase>(getProductsUseCase);

  final userRemoteDataSource = UserRemoteDataSourceImpl(dioClient: dioClient);
  getIt.registerSingleton<UserRemoteDataSource>(userRemoteDataSource);

  final userRepository =
      UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
  getIt.registerSingleton<UserRepository>(userRepository);

  final getUsersUseCase = GetUsersUseCase(repository: userRepository);
  getIt.registerSingleton<GetUsersUseCase>(getUsersUseCase);

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  const storage = FlutterSecureStorage();
  getIt.registerSingleton<FlutterSecureStorage>(storage);

  final themeManager = ThemeManager();
  getIt.registerSingleton<ThemeManager>(themeManager);

  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  String? primaryColorString = prefs.getString('primaryColor');

  Color primaryColor = Colors.teal;
  if (primaryColorString != null) {
    primaryColor = Color(int.parse(primaryColorString));
  }

  themeManager.initTheme(isDarkMode, primaryColor);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsBloc()),
        BlocProvider(
          create: (context) => AuthBloc(
            loginUseCase: getIt<LoginUseCase>(),
            registerUseCase: getIt<RegisterUseCase>(),
            logoutUseCase: getIt<LogoutUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            getProductsUseCase: getIt<GetProductsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            getUsersUseCase: getIt<GetUsersUseCase>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}
