import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/summaries/data/models/summary_model.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_bloc.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCreateForm extends StatefulWidget {
  const SimpleCreateForm({super.key});

  @override
  State<SimpleCreateForm> createState() => SimpleCreateFormState();
}

class SimpleCreateFormState extends State<SimpleCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _commentsController = TextEditingController();
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
              keyboardType: TextInputType.text,
              labelText: 'Título',
              hintText: 'Ingresa el título',
              maxLines: 1,
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El título es obligatorio';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomInputField(
              keyboardType: TextInputType.text,
              labelText: 'Comentarios',
              hintText: 'Ingresa algún comentario',
              maxLines: 5,
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
                    final data = SummaryModel(
                      id: '0',
                      title: _titleController.text,
                      comments: _commentsController.text,
                      status: _isActive,
                    );
                    debugPrint('Crear - Datos del Registro: ${data.toJson()}');
                    context.read<SummaryBloc>().add(CreateSummary(data));
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
