import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:kotik/features/auth/data/auth_data_source.dart';
import 'package:kotik/features/auth/data/auth_repository_impl.dart';
import 'package:kotik/features/auth/domain/repositories/auth_repository.dart';
import 'package:kotik/features/auth/domain/usecases/login_usecase.dart';
import 'package:kotik/features/auth/domain/usecases/logout_usecase.dart';
import 'package:kotik/features/auth/domain/usecases/register_usecase.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies({
  required Future<void> Function() onUnathorized,
}) async {
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton(() => AuthDataSource(firebaseAuth: getIt()));

  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerFactory(
    () => AuthCubit(
      registerUseCase: getIt(),
      loginUseCase: getIt(),
      logoutUseCase: getIt(),
    ),
  );
}
