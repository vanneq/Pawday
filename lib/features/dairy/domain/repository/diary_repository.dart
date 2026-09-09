import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/diary/diary_model.dart';

abstract interface class DiaryRepository {
  Stream<Result<List<DiaryModel>>> watchEntries({
    required String userId,
    required String catId,
  });

  Future<Result<void>> addEntry(
    String userId,
    String catId,
    DiaryParams diaryEntry,
  );
  Future<Result<void>> deleteEntry(String userId, String catId, String entryId);
  Future<Result<void>> updateEntry(
    String userId,
    String catId,
    DiaryModel diaryEntry,
  );
}
