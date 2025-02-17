import 'package:cleancode_app/core/constants/color_constants.dart';
import 'package:cleancode_app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:cleancode_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/get_one_category_usecase.dart';
import 'package:cleancode_app/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:cleancode_app/features/posters/domain/usecases/get_all_posters_usecase.dart';
import 'package:cleancode_app/features/posters/presentation/bloc/poster_bloc.dart';
import 'package:cleancode_app/features/roles/data/datasources/roles_remote_datasource.dart';
import 'package:cleancode_app/features/roles/data/repositories/role_repository_impl.dart';
import 'package:cleancode_app/features/roles/domain/repositories/role_repository.dart';
import 'package:cleancode_app/features/roles/domain/usecases/get_roles_usecase.dart';
import 'package:cleancode_app/features/roles/presentation/bloc/role_bloc.dart';
import 'package:cleancode_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:cleancode_app/service_locator.dart';
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

  final authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
  getIt.registerSingleton<AuthRepository>(authRepository);

  final loginUseCase = LoginUseCase(repository: authRepository);
  getIt.registerSingleton<LoginUseCase>(loginUseCase);

  final isLoggetInUseCase = IsLoggedInUsecase(repository: authRepository);
  getIt.registerSingleton<IsLoggedInUsecase>(isLoggetInUseCase);

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

  final roleRemoteDataSource =
      RoleRemoteDataSourceImpl(dioClient: dioClient);
  getIt.registerSingleton<RoleRemoteDataSource>(roleRemoteDataSource);

  final roleRepository =
      RoleRepositoryImpl(remoteDataSource: roleRemoteDataSource);
  getIt.registerSingleton<RoleRepository>(roleRepository);

  final getRolesUseCase = GetRolesUsecase(repository: roleRepository);
  getIt.registerSingleton<GetRolesUsecase>(getRolesUseCase);

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

  final navigatorKey = GlobalKey<NavigatorState>();
  getIt.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);

  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  String? primaryBgColorString = prefs.getString(ColorConstants.primaryColorName);
  String? primaryTxtColorString = prefs.getString(ColorConstants.primaryTxtColorName);

  Color primaryBgColor = ColorConstants.primaryBgColor;
  if (primaryBgColorString != null) {
    primaryBgColor = Color(int.parse(primaryBgColorString));
  }
  Color primaryTxtColor = ColorConstants.primaryTxtColor;
  if (primaryTxtColorString != null) {
    primaryTxtColor = Color(int.parse(primaryTxtColorString));
  }

  themeManager.initTheme(isDarkMode, primaryBgColor, primaryTxtColor);
  setupServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsBloc()),
        BlocProvider(
          create: (context) => AuthBloc(
            loginUseCase: getIt<LoginUseCase>(),
            registerUseCase: getIt<RegisterUseCase>(),
            logoutUseCase: getIt<LogoutUseCase>(), 
            isLoggedInUseCase: getIt<IsLoggedInUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            getProductsUseCase: getIt<GetProductsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => PosterBloc(getAllPostersUseCase: getIt<GetAllPostersUsecase>()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            getAllCategoriesUseCase: getIt<GetAllCategoriesUsecase>(),
            getOneCategoryUseCase: getIt<GetOneCategoryUsecase>(),
            createCategoryUseCase: getIt<CreateCategoryUsecase>(),
            updateCategoryUseCase: getIt<UpdateCategoryUsecase>(),
            deleteCategoryUseCase: getIt<DeleteCategoryUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            getUsersUseCase: getIt<GetUsersUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => RoleBloc(
            getRolesUserCase: getIt<GetRolesUsecase>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}
