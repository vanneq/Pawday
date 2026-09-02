import 'package:kotik/core/failure/result.dart';
import 'package:kotik/features/main/domain/repository/cat_repository.dart';

class DeleteCatUsecase {
  final CatRepository repository;

  DeleteCatUsecase({required this.repository});
  Future<Result<void>> call(String userId, String catId) async {
    return repository.deleteCat(userId, catId);
  }
}
