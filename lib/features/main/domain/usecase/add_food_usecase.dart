import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/features/main/domain/repository/food_repository.dart';

class AddFoodUsecase {
  final FoodRepository repository;

  AddFoodUsecase({required this.repository});
  Future<Result<void>> call(String userId, List<FoodType> gettingFood) {
    return repository.addFoodDrop(userId, gettingFood);
  }
}
