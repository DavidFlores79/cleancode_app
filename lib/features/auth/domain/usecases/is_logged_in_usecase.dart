import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';

class IsLoggedInUsecase {
  final AuthRepository repository;

  IsLoggedInUsecase({required this.repository});

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}