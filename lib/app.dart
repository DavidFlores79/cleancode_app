import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:cleancode_app/core/theme/theme_manager.dart';
import 'package:cleancode_app/features/auth/presentation/screens/login_screen.dart';
import 'package:cleancode_app/features/auth/presentation/screens/register_screen.dart';
import 'package:cleancode_app/features/home/presentation/screens/home_screen.dart';
import 'package:cleancode_app/features/products/presentation/screens/product_screen.dart';
import 'package:cleancode_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:cleancode_app/features/users/presentation/screens/user_screen.dart';

final navigatorKey = GetIt.I<GlobalKey<NavigatorState>>();

final _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductScreen(),
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
  final themeManager = GetIt.I<ThemeManager>();

  @override
  void initState() {
    super.initState();
    themeManager.callback = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              debugPrint("si se salio");
              final routerContext = navigatorKey.currentContext;
              if(routerContext != null){
                 GoRouter.of(routerContext).go('/');
              }
            }
          },
        )
      ],
      child: MaterialApp.router(
        title: 'My App',
        theme: themeManager.currentTheme,
        routerConfig: _router,
      ),
    );
  }
}
