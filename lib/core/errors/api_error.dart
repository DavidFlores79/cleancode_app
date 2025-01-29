class ApiError {
  final String message;
  final List<FieldError> fieldErrors;

  ApiError({this.message = '', this.fieldErrors = const []});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('errors')) {
      String msg = '';
      // Manejo de errores con lista de campos
      List<FieldError> errors = (json['errors'] as List)
          .map((e) => FieldError.fromJson(e as Map<String, dynamic>))
          .toList();
      if(errors.isNotEmpty) {
        for (var element in errors) {
          msg += '${element.msg}\n'; 
        }
      }
      return ApiError(message: msg, fieldErrors: errors);
    } else if (json.containsKey('msg')) {
       // Manejo de errores con mensaje único
      return ApiError(message: json['msg']);
    }else {
      // Manejo de errores desconocido
      return ApiError(message: 'Error desconocido');
    }

  }

    @override
    String toString() {
      if (message.isNotEmpty) {
        return message;
      } else if (fieldErrors.isNotEmpty) {
        return '$fieldErrors';
      } else {
      return 'Error desconocido';
      }
    }
}

class FieldError {
  final String? value;
  final String msg;
  final String? param;
  final String? location;

  FieldError({this.value, required this.msg, this.param, this.location});

  factory FieldError.fromJson(Map<String, dynamic> json) {
    return FieldError(
        value: json['value'] as String?,
        msg: json['msg'] as String,
        param: json['param'] as String?,
        location: json['location'] as String?
      );
  }

    @override
    String toString() {
      return 'FieldError(value: $value, msg: $msg, param: $param, location: $location)';
    }
}