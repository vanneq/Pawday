import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'diary_model.freezed.dart';
part 'diary_model.g.dart';

enum CatMood {
  funny,
  strange,
  cute,
  sleepy,
  mischievous,
  displeased,
  angry,
  hungry,
}

@freezed
abstract class DiaryModel with _$DiaryModel {
  const factory DiaryModel({
    required String id,
    required String catId,
    String? imageUrl,
    required DateTime createdAt,
    required String description,
    required CatMood mood,
  }) = _DiaryModel;
  factory DiaryModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryModelFromJson(json);
}

class DiaryParams {
  final String catId;
  String? imageUrl;
  File? imageFile;
  final DateTime createdAt;
  final String description;
  final CatMood mood;
  DiaryParams({
    required this.catId,
    required this.createdAt,
    required this.description,
    required this.mood,
    this.imageUrl,
    this.imageFile,
  });
}
