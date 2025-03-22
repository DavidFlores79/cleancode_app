import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/summaries/data/models/summary_model.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_bloc.dart';
import 'package:cleancode_app/features/summaries/presentation/bloc/summary_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleUpdateForm extends StatefulWidget {
  final SummaryModel item;
  const SimpleUpdateForm({super.key, required this.item});

  @override
  State<SimpleUpdateForm> createState() => SimpleUpdateFormState();
}

class SimpleUpdateFormState extends State<SimpleUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _commentsController = TextEditingController();
  bool _isActive = false; // Estado del switch

  @override
  void initState() {
    _titleController.text = widget.item.title!;
    _commentsController.text = widget.item.comments ?? '';
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
            // Campo para el nombre usando CustomInputField
            CustomInputField(
              keyboardType: TextInputType.name,
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
              keyboardType: TextInputType.emailAddress,
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
                text: 'Actualizar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lógica para manejar el formulario válido
                    final data = SummaryModel(
                      id: widget.item.id,
                      title: _titleController.text,
                      comments: _commentsController.text,
                      status: _isActive,
                    );
                    debugPrint('Update - Datos del Registro: ${data.toJson()}');
                    context.read<SummaryBloc>().add(UpdateSummary(data));
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
