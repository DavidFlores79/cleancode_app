import 'package:cleancode_app/core/domain/entities/user.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

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
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Usuarios'),
            onTap: () {
              context.pop();
              context.push('/users');
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Posters'),
            onTap: () {
              context.pop();
              context.push('/products');
            },
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
