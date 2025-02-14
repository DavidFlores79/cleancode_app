import 'package:cleancode_app/core/widgets/error.dart';
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.push('/users');
                        },
                        child: const Text('Ir a Usuarios'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/categories');
                        },
                        child: const Text('Ir a Categorias'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/posters');
                        },
                        child: const Text('Ir a Posters'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/roles');
                        },
                        child: const Text('Ir a Roles (Super)'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          sl<GetModulesUsecase>().call(params: 'xxx');
                        },
                        child: const Text('Traer modulos'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is ModuleFailureState) {
            return Scaffold(
              body: PageError(message: state.errorMessage),
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
