import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCreateForm extends StatefulWidget {
  const SimpleCreateForm({super.key});

  @override
  State<SimpleCreateForm> createState() => SimpleCreateFormState();
}

class SimpleCreateFormState extends State<SimpleCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isActive = true; // Estado del switch

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Campo para el nombre usando CustomInputField
            CustomInputField(
              keyboardType: TextInputType.name,
              labelText: 'Nombre',
              hintText: 'Ingresa el nombre',
              maxLines: 1,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nombre es obligatorio';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInputField(
              keyboardType: TextInputType.emailAddress,
              labelText: 'Email',
              hintText: 'Ingresa el correo',
              maxLines: 1,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email es obligatorio';
                }
                // Expresión regular para validar email
                final emailRegExp =
                    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

                if (!emailRegExp.hasMatch(value)) {
                  return 'Ingresa un correo válido';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInputField(
              obscureText: true,
              keyboardType: TextInputType.text,
              labelText: 'Password',
              hintText: 'Ingresa su contraseña',
              maxLines: 1,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La Contraseña es obligatoria';
                }
                // Expresión regular para validar contraseña segura
                final passwordRegExp =
                    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');

                if (!passwordRegExp.hasMatch(value)) {
                  return '1 mayúscula 1 minúscula y 1 número (8 caracteres)';
                }

                return null;
              },
            ),
            SizedBox(height: 20),
            // Switch para activar/desactivar el estado
            Row(
              children: [
                Text('Estado: ${_isActive ? 'Activo' : 'Inactivo'}'),
                Spacer(),
                Switch(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomButton(
                text: 'Guardar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lógica para manejar el formulario válido
                    final data = UserModel(
                      id: '0',
                      name: _nameController.text,
                      email: _emailController.text,
                      status: _isActive,
                    );
                    debugPrint('Crear - Datos del Registro: $data');
                    context.read<UserBloc>().add(CreateUser(data));
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
