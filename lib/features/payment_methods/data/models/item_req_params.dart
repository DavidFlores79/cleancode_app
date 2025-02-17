class PaymentMethodReqParams {
  final String id;
  final String? name;
  final bool? status;

  PaymentMethodReqParams({required this.id, this.name, this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'name': name,
      'status': status,
    };
  }
}