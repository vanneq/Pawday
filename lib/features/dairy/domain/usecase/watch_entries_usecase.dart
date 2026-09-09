import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/features/dairy/domain/repository/diary_repository.dart';

class WatchEntriesUsecase {
  final DiaryRepository repository;

  WatchEntriesUsecase({required this.repository});
  Stream<Result<List<DiaryModel>>> call(String userId, String catId) {
    return repository.watchEntries(userId: userId, catId: catId);
  }
}
