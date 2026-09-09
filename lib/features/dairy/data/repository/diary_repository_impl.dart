import 'package:flutter/cupertino.dart';
import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/features/dairy/data/datasource/diary_datasource.dart';
import 'package:kotik/features/dairy/domain/repository/diary_repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryDatasource datasource;

  DiaryRepositoryImpl({required this.datasource});

  @override
  Future<Result<void>> addEntry(
    String userId,
    String catId,
    DiaryParams diaryEntry,
  ) async {
    try {
      await datasource.addEntry(userId, catId, diaryEntry);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось добавить запись 😿');
    }
  }

  @override
  Stream<Result<List<DiaryModel>>> watchEntries({
    required String userId,
    required String catId,
  }) async* {
    try {
      await for (final entries in datasource.watchDiary(userId, catId)) {
        yield Success(data: entries);
      }
    } catch (e) {
      debugPrint(e.toString());
      yield Failure<List<DiaryModel>>('Не удалось загрузить записи 😿');
    }
  }

  @override
  Future<Result<void>> updateEntry(
    String userId,
    String catId,
    DiaryModel diaryEntry,
  ) async {
    try {
      await datasource.updateEntry(userId, catId, diaryEntry);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось обновить запись 😿');
    }
  }

  @override
  Future<Result<void>> deleteEntry(
    String userId,
    String catId,
    String entryId,
  ) async {
    try {
      await datasource.deleteEntry(userId, catId, entryId);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось удалить запись 😿');
    }
  }
}
