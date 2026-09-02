import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/features/main/domain/repository/cat_repository.dart';

class UpdateCatUsecase {
  final CatRepository repository;

  UpdateCatUsecase({required this.repository});
  Future<Result<void>> call(String userId, CatModel cat) async {
    return repository.updateCat(userId, cat);
  }
}
