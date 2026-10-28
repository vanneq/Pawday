import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/features/main/domain/repository/food_repository.dart';

class WatchInventoryUsecase {
  final FoodRepository repository;

  WatchInventoryUsecase({required this.repository});
  Stream<Result<Map<FoodType, int>>> call(String userId) {
    return repository.watchInventory(userId);
  }
}
