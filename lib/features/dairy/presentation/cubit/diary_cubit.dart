import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/core/model/user/user_model.dart';
import 'package:kotik/core/usecases/get_current_user_usecase.dart';
import 'package:kotik/features/dairy/domain/usecase/add_entry_usecase.dart';
import 'package:kotik/features/dairy/domain/usecase/delete_entry_usecase.dart';
import 'package:kotik/features/dairy/domain/usecase/update_entry_usecase.dart';
import 'package:kotik/features/dairy/domain/usecase/watch_entries_usecase.dart';
import 'package:kotik/features/dairy/presentation/cubit/diary_state.dart';
import 'package:kotik/features/main/domain/usecase/add_food_usecase.dart';

class DiaryCubit extends Cubit<DiaryState> {
  final AddEntryUsecase addEntryUsecase;
  final UpdateEntryUsecase updateEntryUsecase;
  final WatchEntriesUsecase watchEntriesUsecase;
  final DeleteEntryUsecase deleteEntryUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final AddFoodUsecase addFoodUsecase;

  List<DiaryModel> currentDiaryList = [];
  StreamSubscription<Result<List<DiaryModel>>>? _entriesSubscription;

  DiaryCubit({
    required this.getCurrentUserUsecase,
    required this.addEntryUsecase,
    required this.updateEntryUsecase,
    required this.watchEntriesUsecase,
    required this.deleteEntryUsecase,
    required this.addFoodUsecase,
  }) : super(const DiaryState.initial());

  Future<void> addEntry(DiaryParams newEntry) async {
    final user = _getCurrentUser();
    if (user == null) return;

    emit(const DiaryState.adding());

    final result = await addEntryUsecase(user.uid, newEntry.catId, newEntry);

    if (result is Failure<void>) {
      emit(DiaryState.error(result.message));
      return;
    }
    final random = Random();
    final gettingFood = List.generate(3, (_) => _drawFoodType(random));
    final foodResult = await addFoodUsecase(user.uid, gettingFood);

    if (foodResult is Failure<void>) {
      print('error with getting food in diary_cubit file');
    }
    emit(DiaryState.added(gettingFood));
    _emitLoadedData();
  }

  FoodType _drawFoodType(Random random) {
    final value = random.nextInt(100);

    if (value < 50) return FoodType.feed;
    if (value < 80) return FoodType.fish;
    return FoodType.treats;
  }

  Future<void> deleteEntry({
    required String catId,
    required String entryId,
  }) async {
    final user = _getCurrentUser();
    if (user == null) return;

    final result = await deleteEntryUsecase(user.uid, catId, entryId);

    if (result is Failure<void>) {
      emit(DiaryState.error(result.message));
      return;
    }

    currentDiaryList = currentDiaryList
        .where((entry) => entry.id != entryId)
        .toList();
    emit(const DiaryState.edited());
    _emitLoadedData();
  }

  Future<void> updateEntry(DiaryModel entry) async {
    final user = _getCurrentUser();
    if (user == null) return;

    emit(const DiaryState.editing());

    final result = await updateEntryUsecase(user.uid, entry.catId, entry);

    if (result is Failure<void>) {
      emit(DiaryState.error(result.message));
      return;
    }

    currentDiaryList = currentDiaryList
        .map(
          (currentEntry) => currentEntry.id == entry.id ? entry : currentEntry,
        )
        .toList();

    emit(const DiaryState.edited());
    _emitLoadedData();
  }

  void watchEntries(String catId) {
    final user = _getCurrentUser();
    if (user == null) return;

    emit(const DiaryState.loading());
    _entriesSubscription?.cancel();

    _entriesSubscription = watchEntriesUsecase(user.uid, catId).listen(
      (result) {
        if (result is Success<List<DiaryModel>>) {
          currentDiaryList = result.data;
          _emitLoadedData();
          return;
        }

        if (result is Failure<List<DiaryModel>>) {
          emit(DiaryState.error(result.message));
        }
      },
      onError: (error) {
        emit(DiaryState.error(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _entriesSubscription?.cancel();
    return super.close();
  }

  UserModel? _getCurrentUser() {
    final userResult = getCurrentUserUsecase();

    if (userResult is Failure<UserModel?>) {
      emit(DiaryState.error(userResult.message));
      return null;
    }

    final user = (userResult as Success<UserModel?>).data;

    if (user == null) {
      emit(const DiaryState.error('Необходимо войти в аккаунт'));
      return null;
    }

    return user;
  }

  void _emitLoadedData() {
    emit(DiaryState.loadedData(diaryEntries: currentDiaryList));
  }
}
