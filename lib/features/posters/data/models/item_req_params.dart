class PosterReqParams {
  final String id;
  final String? name;
  final String? category;

  PosterReqParams({required this.id, this.name, this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'name': name,
      'category': category,
    };
  }
}