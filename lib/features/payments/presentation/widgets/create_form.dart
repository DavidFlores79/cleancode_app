import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/payments/data/models/payment_model.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_bloc.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_event.dart';
import 'package:cleancode_app/features/payments/presentation/search/user_search_delegate.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCreateForm extends StatefulWidget {
  const SimpleCreateForm({super.key});

  @override
  State<SimpleCreateForm> createState() => SimpleCreateFormState();
}

class SimpleCreateFormState extends State<SimpleCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _ownerController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _commentsController = TextEditingController();
  bool _isActive = true; // Estado del switch
  List<UserModel> users = [];
  String selectedUserId = '';

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
              suffixIcon: GestureDetector(
                onTap: () => showSearch(
                  context: context,
                  delegate: SearchUsersDelegate(
                    userBloc: context.read<UserBloc>(),
                  ),
                ),
                child: Icon(Icons.search),
              ),
              readOnly: true,
              labelText: 'Cliente',
              hintText: 'Buscar usuario...',
              maxLines: 1,
              controller: _ownerController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El Cliente es obligatorio';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInputField(
              labelText: 'Concepto',
              hintText: 'Ingresa el concepto',
              maxLines: 1,
              controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El concepto es obligatorio';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInputField(
              labelText: 'Comentarios',
              hintText: 'Ingresa algún comentario',
              maxLines: 2,
              controller: _commentsController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Comentarios es obligatorio';
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
                  final data = PaymentModel(
                    id: '0',
                    owner: selectedUserId,
                    description: _descriptionController.text,
                    comments: _commentsController.text,
                    status: _isActive,
                  );
                  debugPrint('Crear - Datos del Registro: $data');
                  context.read<PaymentBloc>().add(CreatePayment(data));
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
