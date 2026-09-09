import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/features/dairy/domain/repository/diary_repository.dart';

class AddEntryUsecase {
  final DiaryRepository repository;

  AddEntryUsecase({required this.repository});
  Future<Result<void>> call(
    String userId,
    String catId,
    DiaryParams diaryEntry,
  ) {
    return repository.addEntry(userId, catId, diaryEntry);
  }
}
