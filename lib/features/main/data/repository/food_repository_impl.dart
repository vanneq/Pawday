import 'package:flutter/foundation.dart';
import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/features/main/data/datasource/food_datasource.dart';
import 'package:kotik/features/main/domain/repository/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodDatasource foodDatasource;

  FoodRepositoryImpl({required this.foodDatasource});
  @override
  Future<Result<void>> addFoodDrop(
    String userId,
    List<FoodType> gettingFood,
  ) async {
    try {
      await foodDatasource.addFoodDrop(userId, gettingFood);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось начислить еду 😿');
    }
  }

  @override
  Future<Result<void>> feedCat(
    String userId,
    String catId,
    FoodType foodType,
  ) async {
    try {
      await foodDatasource.feedCat(userId, catId, foodType);
      return Success(data: null);
    } catch (e) {
      debugPrint(e.toString());
      return Failure<void>('Не удалось покормить кота 😿');
    }
  }

  @override
  Stream<Result<Map<FoodType, int>>> watchInventory(String userId) async* {
    try {
      await for (final foods in foodDatasource.watchInventory(userId)) {
        yield Success(data: foods);
      }
    } catch (e) {
      debugPrint(e.toString());
      yield Failure<Map<FoodType, int>>('Не удалось загрузить еду 😿');
    }
  }
}
