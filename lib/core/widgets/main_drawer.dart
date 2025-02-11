import 'package:cleancode_app/core/domain/entities/user.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:cleancode_app/features/home/domain/entities/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatefulWidget {
  final List<Module> modules;
  
  const MainDrawer({super.key, required this.modules});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final authRepository = GetIt.I<AuthRepository>();
    final user = await authRepository.getLoggedInUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_user?.name ?? 'Not logged'),
            accountEmail: Text(_user?.email ?? 'Login now'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                _user?.name != null ? _user!.name![0].toUpperCase() : 'U',
                style: const TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Column(
            children: widget.modules.map((module) {
              return ListTile(
                leading: const Icon(Icons.image),
                title: Text('${module.name}'),
                onTap: () {
                  context.pop();
                  context.push('/${module.route}');
                },
              );
            },).toList(),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              context.pop();
              context.push('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Salir'),
            onTap: () {
              context.read<AuthBloc>().add(
                LogoutRequested(),
              );
              // context.go('/');
            },
          ),
        ],
      ),
    );
  }
}
