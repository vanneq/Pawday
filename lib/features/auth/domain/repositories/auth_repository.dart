import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/user/user_model.dart';

abstract interface class AuthRepository {
  Future<Result<UserModel>> register(AuthParams user);
  Future<Result<UserModel>> login(AuthParams user);
  Future<Result<void>> logout();
  Result<UserModel?> currentUser();
}
