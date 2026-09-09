import 'package:kotik/core/failure/result.dart';
import 'package:kotik/features/dairy/domain/repository/diary_repository.dart';

class DeleteEntryUsecase {
  final DiaryRepository repository;

  DeleteEntryUsecase({required this.repository});
  Future<Result<void>> call(String userId, String catId, String entryId) {
    return repository.deleteEntry(userId, catId, entryId);
  }
}
