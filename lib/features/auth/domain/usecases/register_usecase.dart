import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/user/user_model.dart';
import 'package:kotik/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Result<UserModel>> call(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      return Failure("Пароли должны совпадать");
    }
    if (password.length < 6) {
      return Failure('Пароль должен содержать не менее 6 символов');
    }
    return repository.register(AuthParams(email: email, password: password));
  }
}
