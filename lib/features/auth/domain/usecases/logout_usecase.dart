import 'package:kotik/core/failure/result.dart';
import 'package:kotik/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Result<void>> call() {
    return repository.logout();
  }
}
