import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kotik/core/model/cat/cat_model.dart';

part 'cats_state.freezed.dart';

@freezed
sealed class CatsState with _$CatsState {
  const factory CatsState.initial() = CatsInitial;
  const factory CatsState.loading() = CatsLoading;
  const factory CatsState.loadedData({required List<CatModel> cats}) =
      CatsLoadedData;
  const factory CatsState.error(String error) = CatsError;
}
