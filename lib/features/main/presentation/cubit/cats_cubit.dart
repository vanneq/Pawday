import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/core/model/user/user_model.dart';
import 'package:kotik/core/usecases/get_current_user_usecase.dart';

import 'package:kotik/features/main/domain/usecase/add_cat_usecase.dart';
import 'package:kotik/features/main/domain/usecase/delete_cat_usecase.dart';
import 'package:kotik/features/main/domain/usecase/update_cat_usecase.dart';
import 'package:kotik/features/main/domain/usecase/watch_cats_usecase.dart';
import 'package:kotik/features/main/presentation/cubit/cats_state.dart';

class CatsCubit extends Cubit<CatsState> {
  final AddCatUsecase addCatUsecase;
  final UpdateCatUsecase updateCatUsecase;
  final WatchCatsUsecase watchCatsUsecase;
  final DeleteCatUsecase deleteCatUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  CatModel? selectedCat;
  List<CatModel> currentCatsList = [];

  CatsCubit({
    required this.addCatUsecase,
    required this.updateCatUsecase,
    required this.watchCatsUsecase,
    required this.deleteCatUsecase,

    required this.getCurrentUserUsecase,
  }) : super(CatsState.initial());

  Future<void> addCat(CreateCatParams newCat) async {
    final user = _getCurrentUser();
    if (user == null) return;

    emit(const CatsState.adding());

    final result = await addCatUsecase(user.uid, newCat);

    if (result is Failure<void>) {
      emit(CatsState.error(result.message));
      return;
    }
    emit(const CatsState.added());
    _emitLoadedData();
  }

  Future<void> deleteCat(String catId) async {
    final user = _getCurrentUser();
    if (user == null) return;
    final result = await deleteCatUsecase(user.uid, catId);
    if (result is Failure<void>) {
      emit(CatsState.error(result.message));
    }
  }

  Future<void> updateCat(CatModel cat) async {
    final user = _getCurrentUser();
    if (user == null) return;
    emit(const CatsState.editing());
    final result = await updateCatUsecase(user.uid, cat);
    if (result is Failure<void>) {
      emit(CatsState.error(result.message));
      return;
    }

    currentCatsList = currentCatsList
        .map((currentCat) => currentCat.id == cat.id ? cat : currentCat)
        .toList();
    if (selectedCat?.id == cat.id) {
      selectedCat = cat;
    }

    emit(const CatsState.edited());
    _emitLoadedData();
  }

  void selectCat(CatModel cat) {
    selectedCat = cat;
    emit(CatsState.loadedData(cats: currentCatsList, selectedCat: selectedCat));
  }

  StreamSubscription<Result<List<CatModel>>>? _catsSubscription;

  void watchCats() {
    final user = _getCurrentUser();
    if (user == null) return;

    emit(CatsState.loading());
    _catsSubscription?.cancel();

    _catsSubscription = watchCatsUsecase(user.uid).listen(
      (result) {
        if (result is Success<List<CatModel>>) {
          currentCatsList = result.data;
          _syncSelectedCat();
          _emitLoadedData();

          return;
        }
        if (result is Failure<List<CatModel>>) {
          emit(CatsState.error(result.message));
        }
      },
      onError: (error) {
        emit(CatsState.error(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _catsSubscription?.cancel();
    return super.close();
  }

  UserModel? _getCurrentUser() {
    final userResult = getCurrentUserUsecase();

    if (userResult is Failure<UserModel?>) {
      emit(CatsState.error(userResult.message));
      return null;
    }

    final user = (userResult as Success<UserModel?>).data;

    if (user == null) {
      emit(const CatsState.error('Необходимо войти в аккаунт'));
      return null;
    }

    return user;
  }

  void _syncSelectedCat() {
    if (currentCatsList.isEmpty) {
      selectedCat = null;
      return;
    }

    final selectedCatId = selectedCat?.id;
    if (selectedCatId == null) {
      selectedCat = currentCatsList.first;
      return;
    }

    for (final cat in currentCatsList) {
      if (cat.id == selectedCatId) {
        selectedCat = cat;
        return;
      }
    }

    selectedCat = currentCatsList.first;
  }

  void _emitLoadedData() {
    emit(CatsState.loadedData(cats: currentCatsList, selectedCat: selectedCat));
  }
}
