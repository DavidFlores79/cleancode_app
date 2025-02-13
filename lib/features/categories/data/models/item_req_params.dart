class CategoryReqParams {
  final String id;
  final String? name;

  CategoryReqParams({required this.id, this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'name': name,
    };
  }
}