import 'package:cleancode_app/core/constants/color_constants.dart';
import 'package:cleancode_app/core/domain/entities/user.dart';
import 'package:cleancode_app/core/widgets/custom_button.dart';
import 'package:cleancode_app/core/widgets/custom_input_field.dart';
import 'package:cleancode_app/features/payment_methods/data/models/payment_method_model.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_bloc.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_event.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_state.dart';
import 'package:cleancode_app/features/payments/data/models/payment_model.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_bloc.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_event.dart';
import 'package:cleancode_app/features/payments/presentation/search/user_search_delegate.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_bloc.dart';
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
  final _amountController = TextEditingController();
  final _ownerController = TextEditingController();
  bool _isActive = false; // Estado del switch
  List<UserModel> users = [];
  List<PaymentMethodModel> options = [];
  String selectedUserId = '';
  String selectedPaymentMethodId = '';

  @override
  void initState() {
    context.read<PaymentMethodBloc>().add(GetAllPaymentMethods());
    _intializeFormValues();
    super.initState();
  }

  void _intializeFormValues() {
    _descriptionController.text = widget.item.description!;
    _commentsController.text = widget.item.comments!;
    _amountController.text = widget.item.amount.toString();
    _isActive = widget.item.status!;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentMethodBloc, PaymentMethodState>(
          listener: (context, state) {
            if (state is GetAllPaymentMethodsSuccessState) {
              _initializeSelectValues(state);
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInputField(
                onTap: () async {
                  selectedUserId = '';
                  _ownerController.text = '';
                  final user = await showSearch(
                    context: context,
                    delegate: SearchUsersDelegate(
                      userBloc: context.read<UserBloc>(),
                    ),
                  );
                  if (user is UserModel) {
                    selectedUserId = user.id.toString();
                    _ownerController.text = user.name.toString();
                  }
                },
                suffixIcon: Icon(Icons.search),
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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                labelText: 'Cantidad',
                hintText: 'Ingresa la cantidad',
                maxLines: 1,
                controller: _amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La cantidad es obligatoria';
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.grey),
                   borderRadius: BorderRadius.circular(8), // Borde redondeado
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: selectedPaymentMethodId,
                  hint: Text('Mètodo de Pago'),
                  onChanged:(value) {
                    debugPrint("Valor escogido: $value");
                    setState(() {
                      if(value != null) selectedPaymentMethodId = value;
                      
                    });
                  },
                  items: options.map<DropdownMenuItem<String>>((PaymentMethodModel option) {
                    return DropdownMenuItem<String>(
                      value: option.id,
                      child: Text(option.name ?? ''),
                    );
                  }).toList(),
                ),
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
                        owner: selectedUserId,
                        paymentMethod: selectedPaymentMethodId,
                        amount: double.tryParse(_amountController.text),
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
      ),
    );
  }

  void _initializeSelectValues(GetAllPaymentMethodsSuccessState state) {
    setState(() {
      final currentOwner = (widget.item.owner is String) ? widget.item.owner : widget.item.owner as User;
      final currentMethod = (widget.item.paymentMethod is String) ? widget.item.paymentMethod : widget.item.paymentMethod as PaymentMethodModel;
      _ownerController.text = (widget.item.owner is String) ? currentOwner : currentOwner.name;
      selectedPaymentMethodId = (widget.item.paymentMethod is String) ? currentMethod : currentMethod.id!;
      selectedUserId = currentOwner.id!;
      options = state.items;
    });
  }
}
