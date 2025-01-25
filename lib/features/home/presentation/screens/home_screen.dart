import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
          IconButton(
              onPressed: (){
                context.read<AuthBloc>().add(LogoutRequested());
                context.go('/');
              },
              icon: const Icon(Icons.logout)),
           IconButton(
                onPressed: () {
                  context.push('/settings');
                },
                icon: const Icon(Icons.settings)),
        ],
        ),
        body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                 context.push('/users');
              },
              child: const Text('Ir a Usuarios'),
            ),
            ElevatedButton(
              onPressed: () {
                 context.push('/products');
              },
              child: const Text('Ir a Productos'),
            ),
          ],
        ),
      ),
    );
  }
}