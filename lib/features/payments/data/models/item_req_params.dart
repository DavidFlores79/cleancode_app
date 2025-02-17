class PaymentReqParams {
  final String id;
  final String? description;
  final String? comments;
  final double? amount;
  final bool? status;

  PaymentReqParams({required this.id, this.description, this.status, this.comments, this.amount});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'description': description,
      'comments': comments,
      'amount': amount,
      'status': status,
    };
  }
}