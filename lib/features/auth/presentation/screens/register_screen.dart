import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
           context.go('/home');
          } else if (state is AuthFailure) {
           AppUtils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
           return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre';
                          }
                           return null;
                        },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                         validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu email';
                           }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa tu password';
                           }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        text: 'Register',
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            context.read<AuthBloc>().add(RegisterRequested(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text));
                          }
                        },
                      )
                       ,
                      const SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
                      )
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}