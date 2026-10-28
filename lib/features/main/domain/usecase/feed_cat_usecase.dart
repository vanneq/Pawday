import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/features/main/domain/repository/food_repository.dart';

class FeedCatUsecase {
  final FoodRepository repository;

  FeedCatUsecase({required this.repository});
  Future<Result<void>> call(String userId, String catId, FoodType foodType) {
    return repository.feedCat(userId, catId, foodType);
  }
}
