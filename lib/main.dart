import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(dioClient: dioClient);
  final authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
  final loginUseCase = LoginUseCase(repository: authRepository);
  final registerUseCase = RegisterUseCase(repository: authRepository);

  final productRemoteDataSource = ProductRemoteDataSourceImpl(dioClient: dioClient);
  final productRepository = ProductRepositoryImpl(remoteDataSource: productRemoteDataSource);
  final getProductsUseCase = GetProductsUseCase(repository: productRepository);

  final userRemoteDataSource = UserRemoteDataSourceImpl(dioClient: dioClient);
  final userRepository = UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
  final getUsersUseCase = GetUsersUseCase(repository: userRepository);


  final prefs = await SharedPreferences.getInstance();
  const storage = FlutterSecureStorage();

   bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
   String? primaryColorString = prefs.getString('primaryColor');

    Color primaryColor = Colors.blue;
    if (primaryColorString != null) {
        primaryColor = Color(int.parse(primaryColorString));
    }
  runApp(
    ProviderScope(
        child: MultiBlocProvider(
            providers: [
                BlocProvider(create: (context) => AuthBloc(loginUseCase: loginUseCase, registerUseCase: registerUseCase)),
                 BlocProvider(create: (context) => ProductBloc(getProductsUseCase: getProductsUseCase)),
                 BlocProvider(create: (context) => UserBloc(getUsersUseCase: getUsersUseCase)),
                  ],
             child:  MyApp(),
           ),
         ),
      );
        ThemeManager().initTheme(isDarkMode, primaryColor);
}