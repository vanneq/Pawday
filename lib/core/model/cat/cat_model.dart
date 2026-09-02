import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_model.freezed.dart';
part 'cat_model.g.dart';

enum CatColoration { ginger, black, gray, white, brown, tricolor, tabby }

enum Character { calm, playful, curious, capricious, lazy }

@freezed
abstract class CatModel with _$CatModel {
  const factory CatModel({
    required String id,
    required String name,
    required DateTime createdAt,
    required CatColoration color,
    required int dayWithCat,
    required int dairyEntries,
    Character? character,
  }) = _CatModel;
  factory CatModel.fromJson(Map<String, dynamic> json) =>
      _$CatModelFromJson(json);
}

class CreateCatParams {
  final String name;
  final DateTime createdAt;
  final CatColoration color;
  final int dayWithCat;
  final int dairyEntries;
  final Character? character;

  const CreateCatParams({
    required this.name,
    required this.createdAt,
    required this.color,
    required this.dayWithCat,
    required this.dairyEntries,
    this.character,
  });
}
