import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kotik/core/usecases/get_current_user_usecase.dart';
import 'package:kotik/features/auth/data/auth_data_source.dart';
import 'package:kotik/features/auth/data/auth_repository_impl.dart';
import 'package:kotik/features/auth/domain/repositories/auth_repository.dart';
import 'package:kotik/features/auth/domain/usecases/login_usecase.dart';
import 'package:kotik/features/auth/domain/usecases/logout_usecase.dart';
import 'package:kotik/features/auth/domain/usecases/register_usecase.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kotik/features/dairy/data/datasource/diary_datasource.dart';
import 'package:kotik/features/dairy/data/repository/diary_repository_impl.dart';
import 'package:kotik/features/dairy/domain/repository/diary_repository.dart';
import 'package:kotik/features/dairy/domain/usecase/add_entry_usecase.dart';
import 'package:kotik/features/dairy/domain/usecase/delete_entry_usecase.dart';
import 'package:kotik/features/dairy/domain/usecase/update_entry_usecase.dart';
import 'package:kotik/features/dairy/domain/usecase/watch_entries_usecase.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_cubit.dart';
import 'package:kotik/features/main/data/datasource/cats_datasource.dart';
import 'package:kotik/features/main/data/repository/cat_repository_impl.dart';
import 'package:kotik/features/main/domain/repository/cat_repository.dart';
import 'package:kotik/features/main/domain/usecase/add_cat_usecase.dart';
import 'package:kotik/features/main/domain/usecase/delete_cat_usecase.dart';
import 'package:kotik/features/main/domain/usecase/update_cat_usecase.dart';
import 'package:kotik/features/main/domain/usecase/watch_cats_usecase.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies({
  required Future<void> Function() onUnathorized,
}) async {
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseStorage.instance);

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: getIt()),
  );
  getIt.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(catsDatasource: getIt()),
  );
  getIt.registerLazySingleton<DiaryRepository>(
    () => DiaryRepositoryImpl(datasource: getIt()),
  );

  getIt.registerLazySingleton(() => AuthDataSource(firebaseAuth: getIt()));
  getIt.registerLazySingleton(() => CatsDatasource(firestore: getIt()));
  getIt.registerLazySingleton(
    () => DiaryDatasource(firestore: getIt(), storage: getIt()),
  );

  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));

  getIt.registerLazySingleton(
    () => GetCurrentUserUsecase(authRepository: getIt()),
  );

  getIt.registerLazySingleton(() => AddCatUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateCatUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => DeleteCatUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => WatchCatsUsecase(repository: getIt()));

  getIt.registerLazySingleton(() => AddEntryUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateEntryUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => DeleteEntryUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => WatchEntriesUsecase(repository: getIt()));

  getIt.registerFactory(
    () => AuthCubit(
      registerUseCase: getIt(),
      loginUseCase: getIt(),
      logoutUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => CatsCubit(
      addCatUsecase: getIt(),
      deleteCatUsecase: getIt(),
      watchCatsUsecase: getIt(),
      updateCatUsecase: getIt(),
      getCurrentUserUsecase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => DiaryCubit(
      addEntryUsecase: getIt(),
      deleteEntryUsecase: getIt(),
      watchEntriesUsecase: getIt(),
      updateEntryUsecase: getIt(),
      getCurrentUserUsecase: getIt(),
    ),
  );
}
