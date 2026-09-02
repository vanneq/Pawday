import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/features/main/domain/repository/cat_repository.dart';

class AddCatUsecase {
  final CatRepository repository;

  AddCatUsecase({required this.repository});
  Future<Result<void>> call(String userId, CreateCatParams cat) {
    return repository.addCat(userId, cat);
  }
}
