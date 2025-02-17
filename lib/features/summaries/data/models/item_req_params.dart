class SummaryReqParams {
  final String id;
  final String? title;
  final String? comments;
  final bool? status;

  SummaryReqParams({required this.id, this.title, this.status, this.comments});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'title': title,
      'comments': comments,
      'status': status,
    };
  }
}