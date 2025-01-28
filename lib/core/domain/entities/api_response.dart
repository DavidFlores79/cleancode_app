class ApiResponse<T> {
  final T? data;
  final String? message;
  final int? statusCode;
    final bool? success;
    final List<String>? errors;
    
  ApiResponse({this.data, this.message, this.statusCode, this.success, this.errors});


    factory ApiResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) fromJsonT) {
      return ApiResponse<T>(
        success: json['success'],
            statusCode: json['statusCode'],
              data: json['data'] != null ? fromJsonT(json['data']) : null,
        message: json['message'],
            errors: json['errors'] != null ?  List<String>.from(json['errors'].map((x) => x['msg'])): null,
      );
    }
}