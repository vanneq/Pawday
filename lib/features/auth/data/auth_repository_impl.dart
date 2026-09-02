import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/user/user_model.dart';
import 'package:kotik/features/auth/data/auth_data_source.dart';
import 'package:kotik/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Result<UserModel>> register(AuthParams user) async {
    try {
      final credential = await dataSource.register(user.email, user.password);
      return _mapCredentialToUser(credential);
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e.code));
    } catch (e) {
      return Failure('Неизвестная ошибка, повторите позже');
    }
  }

  @override
  Future<Result<UserModel>> login(AuthParams user) async {
    try {
      final credential = await dataSource.login(user.email, user.password);
      return _mapCredentialToUser(credential);
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e.code));
    } catch (e) {
      return Failure('Неизвестная ошибка, повторите позже');
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await dataSource.logout();
      return Success(data: null);
    } catch (e) {
      return Failure('Не удалось выйти. Попробуйте позже');
    }
  }

  Result<UserModel> _mapCredentialToUser(UserCredential credential) {
    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      return Failure('Не удалось получить данные пользователя');
    }

    return Success(data: _mapFirebaseUser(firebaseUser));
  }

  @override
  Result<UserModel?> currentUser() {
    final user = dataSource.getCurrentUser();
    if (user == null) return Success(data: null);

    return Success(data: _mapFirebaseUser(user));
  }

  UserModel _mapFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Этот email уже зарегистрирован';
      case 'invalid-email':
        return 'Некорректный email';
      case 'weak-password':
        return 'Пароль слишком слабый (минимум 6 символов)';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Неверный email или пароль';
      case 'user-disabled':
        return 'Аккаунт заблокирован';
      case 'too-many-requests':
        return 'Слишком много попыток. Попробуйте позже';
      default:
        return 'Ошибка: $code';
    }
  }
}
