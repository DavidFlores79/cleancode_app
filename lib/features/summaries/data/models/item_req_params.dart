class SummaryReqParams {
  final String id;
  final String? title;
  final String? comments;
  final double? amount;
  final bool? status;

  SummaryReqParams({required this.id, this.title, this.status, this.comments, this.amount});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'name': title,
      'status': status,
    };
  }
}