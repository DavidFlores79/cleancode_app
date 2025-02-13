import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/categories/data/models/category_model.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:cleancode_app/features/categories/presentation/bloc/category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleForm extends StatefulWidget {
  final CategoryModel item;
  const SimpleForm({super.key, required this.item});

  @override
  State<SimpleForm> createState() => SimpleFormState();
}

class SimpleFormState extends State<SimpleForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isActive = false; // Estado del switch

  @override
  void initState() {
    _nameController.text = widget.item.name!;
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
              labelText: 'Nombre',
              hintText: 'Ingresa el nombre',
              maxLines: 5,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
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
                    final data = CategoryModel(
                      id: widget.item.id,
                      name: _nameController.text,
                      status: _isActive,
                    );
                    print('Datos del usuario: $data');
                    context.read<CategoryBloc>().add(UpdateCategory(data));
                  }
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
