import 'package:cleancode_app/core/widgets/main_drawer.dart';
import 'package:cleancode_app/features/home/domain/usecases/get_modules_usecase.dart';
import 'package:cleancode_app/service_locator.dart';
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
        title: const Text('Inicio'),
        actions: [],
      ),
      drawer: MainDrawer(),
      body: Center(
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
            ElevatedButton(
              onPressed: () {
                context.push('/roles');
              },
              child: const Text('Ir a Roles (Super)'),
            ),
            ElevatedButton(
              onPressed: () {
                sl<GetModulesUsecase>().call(
                  param: 'xxx'
                );
              },
              child: const Text('Traer modulos'),
            ),
          ],
        ),
      ),
    );
  }
}
