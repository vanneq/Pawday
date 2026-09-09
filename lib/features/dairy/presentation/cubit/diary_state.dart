import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kotik/core/model/diary/diary_model.dart';

part 'diary_state.freezed.dart';

@freezed
sealed class DiaryState with _$DiaryState {
  const factory DiaryState.initial() = DiaryInitial;
  const factory DiaryState.loading() = DiaryLoading;
  const factory DiaryState.loadedData({
    required List<DiaryModel> diaryEntries,
  }) = DiaryLoadedData;
  const factory DiaryState.error(String error) = DiaryError;

  const factory DiaryState.adding() = DiaryAdding;
  const factory DiaryState.added() = DiaryAdded;

  const factory DiaryState.editing() = DiaryEditing;
  const factory DiaryState.edited() = DiaryEdited;

  const factory DiaryState.selected() = DiarySelected;
}
