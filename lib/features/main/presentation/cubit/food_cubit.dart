import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kotik/core/failure/result.dart';
import 'package:kotik/core/model/food/food_model.dart';
import 'package:kotik/core/model/user/user_model.dart';
import 'package:kotik/core/usecases/get_current_user_usecase.dart';
import 'package:kotik/features/main/domain/usecase/add_food_usecase.dart';
import 'package:kotik/features/main/domain/usecase/feed_cat_usecase.dart';
import 'package:kotik/features/main/domain/usecase/watch_inventory_usecase.dart';
import 'package:kotik/features/main/presentation/cubit/food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  final FeedCatUsecase feedCatUsecase;
  final WatchInventoryUsecase watchInventoryUsecase;
  final AddFoodUsecase addFoodUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  Map<FoodType, int> inventory = {};

  FoodCubit({
    required this.feedCatUsecase,
    required this.watchInventoryUsecase,
    required this.addFoodUsecase,
    required this.getCurrentUserUsecase,
  }) : super(FoodState.initial());

  Future<void> addFoodDrop(String userId, List<FoodType> gettingFood) async {
    _setOperationProgress(true);
    final result = await addFoodUsecase(userId, gettingFood);
    if (result is Failure<void>) {
      _setOperationProgress(false);
      emit(FoodState.error(result.message));
      return;
    }

    _setOperationProgress(false);
  }

  Future<bool> feedCat(String catId, FoodType foodType) async {
    final userResult = getCurrentUserUsecase();
    if (userResult is Failure<UserModel?>) {
      emit(FoodState.error(userResult.message));
      return false;
    }
    final user = (userResult as Success<UserModel?>).data;
    if (user == null) {
      emit(const FoodState.error('Необходимо войти в аккаунт'));
      return false;
    }
    _setOperationProgress(true);

    final result = await feedCatUsecase(user.uid, catId, foodType);

    if (result is Failure<void>) {
      _setOperationProgress(false);
      emit(FoodState.error(result.message));
      return false;
    }

    _setOperationProgress(false);
    return true;
  }

  void watchInventory() {
    final userResult = getCurrentUserUsecase();
    if (userResult is Failure<UserModel?>) {
      emit(FoodState.error(userResult.message));
      return;
    }
    final user = (userResult as Success<UserModel?>).data;
    if (user == null) {
      emit(const FoodState.error('Необходимо войти в аккаунт'));
      return;
    }

    emit(FoodState.loading());
    _inventorySubscription?.cancel();
    _inventorySubscription = watchInventoryUsecase(user.uid).listen((result) {
      if (result is Success<Map<FoodType, int>>) {
        inventory = result.data;
        _emitLoadedData();
      } else if (result is Failure<Map<FoodType, int>>) {
        emit(FoodState.error(result.message));
      }
    });
  }

  @override
  Future<void> close() {
    _inventorySubscription?.cancel();
    return super.close();
  }

  void _emitLoadedData() {
    emit(
      FoodState.loadedData(inventory: inventory, isOperationProgress: false),
    );
  }

  void _setOperationProgress(bool value) {
    final currentState = state;
    if (currentState is FoodsLoadedData) {
      emit(currentState.copyWith(isOperationProgress: value));
    }
  }

  StreamSubscription<Result<Map<FoodType, int>>>? _inventorySubscription;
}
