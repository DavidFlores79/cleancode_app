import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> options; // Lista de opciones
  final String? selectedId; // ID de la opción seleccionada
  final Function(String?) onChanged; // Callback cuando se selecciona una opción
  final String hint; // Texto de hint

  const CustomDropdown({
    Key? key,
    required this.options,
    required this.selectedId,
    required this.onChanged,
    this.hint = 'Selecciona una opción',
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {

  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedId,
      hint: Text(widget.hint),
      onChanged: widget.onChanged,
      items: widget.options.map<DropdownMenuItem<String>>((Map<String, dynamic> option) {
        return DropdownMenuItem<String>(
          value: option['id'],
          child: Text(option['name']),
        );
      }).toList(),
    );
  }
}