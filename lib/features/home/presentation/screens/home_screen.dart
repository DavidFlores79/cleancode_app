import 'package:cleancode_app/core/widgets/main_drawer.dart';
import 'package:cleancode_app/features/home/domain/usecases/get_modules_usecase.dart';
import 'package:cleancode_app/features/home/presentation/bloc/module_bloc.dart';
import 'package:cleancode_app/features/home/presentation/bloc/module_state.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ModuleCubit()..getModules(),
      child: BlocBuilder<ModuleCubit, ModuleState>(
        builder: (BuildContext context, state) {
          if (state is ModuleLoadingState) {
            return Scaffold(
              body: Center(
                child: const CircularProgressIndicator(),
              ),
            );
          }
          if (state is ModuleSuccessState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Inicio'),
                actions: [],
              ),
              drawer: MainDrawer(modules: state.modules),
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
                        sl<GetModulesUsecase>().call(param: 'xxx');
                      },
                      child: const Text('Traer modulos'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is ModuleFailureState) {
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text('Sin Nada'),
            ),
          );
        },
      ),
    );
  }
}
