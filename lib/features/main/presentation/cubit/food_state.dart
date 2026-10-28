import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kotik/core/model/food/food_model.dart';

part 'food_state.freezed.dart';

@freezed
sealed class FoodState with _$FoodState {
  const factory FoodState.initial() = FoodInitial;
  const factory FoodState.loading() = FoodLoading;
  const factory FoodState.success() = FoodSuccess;
  const factory FoodState.loadedData({
    required Map<FoodType, int> inventory,
    required bool isOperationProgress,
  }) = FoodsLoadedData;
  const factory FoodState.error(String error) = FoodError;
}
