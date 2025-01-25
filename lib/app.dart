import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cleancode_app/core/theme/theme_manager.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
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


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'My App',
      theme: theme,
      routerConfig: _router,
    );
  }
}