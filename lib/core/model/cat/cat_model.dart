import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_model.freezed.dart';
part 'cat_model.g.dart';

enum CatColoration { ginger, black, gray, white, brown, tricolor, tabby }

enum CatCharacter { calm, playful, curious, capricious, lazy }

@freezed
abstract class CatModel with _$CatModel {
  const factory CatModel({
    required String id,
    required String name,
    required DateTime createdAt,
    required CatColoration color,

    required int dairyEntries,
    CatCharacter? character,
  }) = _CatModel;
  factory CatModel.fromJson(Map<String, dynamic> json) =>
      _$CatModelFromJson(json);
}

class CreateCatParams {
  final String name;
  final DateTime createdAt;
  final CatColoration color;

  final int dairyEntries;
  final CatCharacter? character;

  const CreateCatParams({
    required this.name,
    required this.createdAt,
    required this.color,
    required this.dairyEntries,
    this.character,
  });
}
