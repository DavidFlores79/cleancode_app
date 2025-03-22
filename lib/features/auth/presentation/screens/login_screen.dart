import 'package:cleancode_app/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:cleancode_app/core/utils/app_utils.dart';
import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RiveAnimatedIcon(
                      riveIcon: RiveIcon.home,
                      width: 50,
                      height: 50,
                      color: Colors.green,
                      strokeWidth: 3,
                      loopAnimation: false,
                      onTap: () {},
                      onHover: (value) {},
                    ),
                    // Image.asset(state.isDarkMode ? 'assets/images/padlock-white.png' : 'assets/images/padlock.png', width: 180),
                    SizedBox(height: 40),
                    CustomInputField(
                      keyboardType: TextInputType.name,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa tu email';
                        }
                        // Expresión regular para validar email
                        final emailRegExp = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

                        if (!emailRegExp.hasMatch(value)) {
                          return 'Ingresa un correo válido';
                        }
                        return null;
                      },
                      labelText: 'Email',
                      hintText: 'Ingresa tu Email',
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Password',
                      hintText: '8 caracteres',
                      controller: _passwordController,
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
                      text: 'Iniciar Sesión',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                LoginRequested(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        context.push('/register');
                      },
                      child: const Text('¿No tienes una cuenta? Regístrate'),
                    )
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
