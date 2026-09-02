import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/user/user_model.dart';
import 'package:kotik/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository authRepository;

  GetCurrentUserUsecase({required this.authRepository});

  Result<UserModel?> call() {
    return authRepository.currentUser();
  }
}
