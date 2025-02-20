import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleUpdateForm extends StatefulWidget {
  final UserModel item;
  const SimpleUpdateForm({super.key, required this.item});

  @override
  State<SimpleUpdateForm> createState() => SimpleUpdateFormState();
}

class SimpleUpdateFormState extends State<SimpleUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isActive = false; // Estado del switch

  @override
  void initState() {
    _nameController.text = widget.item.name!;
    _emailController.text = widget.item.email!;
    _isActive = widget.item.status!;
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
            SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage('${widget.item.image}'),
              ),
            ),
            const SizedBox(height: 30),
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
                text: 'Actualizar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lógica para manejar el formulario válido
                    final data = UserModel(
                      id: widget.item.id,
                      image: widget.item.image,
                      name: _nameController.text,
                      email: _emailController.text,
                      role: widget.item.role.id,
                      status: _isActive,
                    );
                    debugPrint('Update - Datos del Registro: ${data.toJson()}');
                    context.read<UserBloc>().add(UpdateUser(data));
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
