import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/features/dairy/domain/repository/diary_repository.dart';

class UpdateEntryUsecase {
  final DiaryRepository repository;

  UpdateEntryUsecase({required this.repository});
  Future<Result<void>> call(
    String userId,
    String catId,
    DiaryModel diaryEntry,
  ) {
    return repository.updateEntry(userId, catId, diaryEntry);
  }
}
