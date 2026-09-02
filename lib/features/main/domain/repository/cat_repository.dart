import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/cat/cat_model.dart';

abstract interface class CatRepository {
  Stream<Result<List<CatModel>>> watchCats(String userId);
  Future<Result<void>> addCat(String userId, CreateCatParams cat);
  Future<Result<void>> deleteCat(String userId, String catId);
  Future<Result<void>> updateCat(String userId, CatModel cat);
}
