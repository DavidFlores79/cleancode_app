import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:cleancode_app/core/theme/theme_manager.dart';
import 'package:cleancode_app/features/auth/presentation/screens/login_screen.dart';
import 'package:cleancode_app/features/auth/presentation/screens/register_screen.dart';
import 'package:cleancode_app/features/home/presentation/screens/home_screen.dart';
import 'package:cleancode_app/features/products/presentation/screens/product_screen.dart';
import 'package:cleancode_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:cleancode_app/features/users/presentation/screens/user_screen.dart';

final _router = GoRouter(
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


class MyApp extends StatelessWidget {
  MyApp({super.key});
 final themeManager = GetIt.I<ThemeManager>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      theme: themeManager.currentTheme,
      routerConfig: _router,
    );
  }
}