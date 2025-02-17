import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/payments/data/models/payment_model.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_bloc.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleUpdateForm extends StatefulWidget {
  final PaymentModel item;
  const SimpleUpdateForm({super.key, required this.item});

  @override
  State<SimpleUpdateForm> createState() => SimpleUpdateFormState();
}

class SimpleUpdateFormState extends State<SimpleUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _commentsController = TextEditingController();
  bool _isActive = false; // Estado del switch

  @override
  void initState() {
    _descriptionController.text = widget.item.description!;
    _commentsController.text = widget.item.comments!;
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
              labelText: 'Concepto',
              hintText: 'Ingresa el concepto de pago',
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
                    final data = PaymentModel(
                      id: widget.item.id,
                      description: _descriptionController.text,
                      comments: _commentsController.text,
                      status: _isActive,
                    );
                    debugPrint('Update - Datos del Registro: $data');
                    context.read<PaymentBloc>().add(UpdatePayment(data));
                  }
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
