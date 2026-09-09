// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiaryModel _$DiaryModelFromJson(Map<String, dynamic> json) => _DiaryModel(
  id: json['id'] as String,
  catId: json['catId'] as String,
  imageUrl: json['imageUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  description: json['description'] as String,
  mood: $enumDecode(_$CatMoodEnumMap, json['mood']),
);

Map<String, dynamic> _$DiaryModelToJson(_DiaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'catId': instance.catId,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'mood': _$CatMoodEnumMap[instance.mood]!,
    };

const _$CatMoodEnumMap = {
  CatMood.funny: 'funny',
  CatMood.strange: 'strange',
  CatMood.cute: 'cute',
  CatMood.sleepy: 'sleepy',
  CatMood.mischievous: 'mischievous',
  CatMood.displeased: 'displeased',
  CatMood.angry: 'angry',
  CatMood.hungry: 'hungry',
};
