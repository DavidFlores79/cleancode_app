import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/theme/app_theme.dart';
import 'package:cleancode_app/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:cleancode_app/features/categories/presentation/screens/category_screen.dart';
import 'package:cleancode_app/features/payment_methods/presentation/screens/payment_method_screen.dart';
import 'package:cleancode_app/features/payments/presentation/screens/payment_screen.dart';
import 'package:cleancode_app/features/posters/presentation/screens/poster_screen.dart';
import 'package:cleancode_app/features/roles/presentation/screens/role_screen.dart';
import 'package:cleancode_app/features/summaries/presentation/screens/summary_screen.dart';
import 'package:cleancode_app/features/users/presentation/screens/user_screen.dart';
import 'package:cleancode_app/onboarding/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:cleancode_app/features/auth/presentation/screens/login_screen.dart';
import 'package:cleancode_app/features/auth/presentation/screens/register_screen.dart';
import 'package:cleancode_app/features/home/presentation/screens/home_screen.dart';
import 'package:cleancode_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:logger/logger.dart';

import 'core/widgets/main_layout.dart';

final navigatorKey = GetIt.I<GlobalKey<NavigatorState>>();

final _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/welcome',
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => MainLayout(child: const LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => MainLayout(child: const HomeScreen()),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
      path: '/posters',
      builder: (context, state) => const PosterScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoryScreen(),
    ),
    GoRoute(
      path: '/summaries',
      builder: (context, state) => const SummaryScreen(),
    ),
    GoRoute(
      path: '/payments',
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: '/payment-methods',
      builder: (context, state) => const PaymentMethodScreen(),
    ),
    GoRoute(
      path: '/roles',
      builder: (context, state) => const RolesScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    )
  ],
);

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IsLoggetInRequested());
  }

  @override
  Widget build(BuildContext context) {
    Logger logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        colors: true,
        printEmojis: true,
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              logger.t('Tiene sesión valida'); //Info log
              final routerContext = navigatorKey.currentContext;
              if (routerContext != null) {
                GoRouter.of(routerContext).go('/home');
              }
            }
            if (state is Unauthenticated) {
              logger.t('Ya no está autenticado'); //Info log
              final routerContext = navigatorKey.currentContext;
              if (routerContext != null) {
                GoRouter.of(routerContext).go('/welcome');
              }
            }
          },
        ),
        BlocListener<ThemeBloc, ThemeState>(
          listener:(context, state) {
            print("Rebuilding SettingsScreen with state: ${state.isDarkMode}");
          },
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          print("Rebuilding SettingsScreen with state: ${state.isDarkMode}");

          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: AppConstants.isDebug,
            theme: AppTheme.getTheme(
              state.isDarkMode,
              state.primaryBgColor,
              primaryTxtColor: state.primaryTxtColor,
            ),
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
