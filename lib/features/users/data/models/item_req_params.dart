class UserReqParams {
  final String id;
  final String? name;
  final String? email;
  final String? password;
  final String? image;
  final bool? status;

  UserReqParams({required this.id, this.name, this.status, this.email, this.image, this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'status': status,
    };
  }
}