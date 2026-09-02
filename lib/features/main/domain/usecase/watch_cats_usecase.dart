import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/features/main/domain/repository/cat_repository.dart';

class WatchCatsUsecase {
  final CatRepository repository;

  WatchCatsUsecase({required this.repository});
  Stream<Result<List<CatModel>>> call(String userId) {
    return repository.watchCats(userId);
  }
}
