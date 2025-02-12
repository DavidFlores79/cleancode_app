class ProductReqParams {
  final String id;

  ProductReqParams({required this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id
    };
  }
}