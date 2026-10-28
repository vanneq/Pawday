import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/food/food_model.dart';

abstract interface class FoodRepository {
  Stream<Result<Map<FoodType, int>>> watchInventory(String userId);
  Future<Result<void>> feedCat(String userId, String catId, FoodType foodType);
  Future<Result<void>> addFoodDrop(String userId, List<FoodType> gettingFood);
}
