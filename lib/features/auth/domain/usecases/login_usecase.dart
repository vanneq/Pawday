import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/user/user_model.dart';
import 'package:kotik/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Result<UserModel>> call(String email, String password) async {
    return repository.login(AuthParams(email: email, password: password));
  }
}
