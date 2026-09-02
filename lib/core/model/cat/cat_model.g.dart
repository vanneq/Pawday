// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatModel _$CatModelFromJson(Map<String, dynamic> json) => _CatModel(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  color: $enumDecode(_$CatColorationEnumMap, json['color']),
  dayWithCat: (json['dayWithCat'] as num).toInt(),
  dairyEntries: (json['dairyEntries'] as num).toInt(),
  character: $enumDecodeNullable(_$CharacterEnumMap, json['character']),
);

Map<String, dynamic> _$CatModelToJson(_CatModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': instance.createdAt.toIso8601String(),
  'color': _$CatColorationEnumMap[instance.color]!,
  'dayWithCat': instance.dayWithCat,
  'dairyEntries': instance.dairyEntries,
  'character': _$CharacterEnumMap[instance.character],
};

const _$CatColorationEnumMap = {
  CatColoration.ginger: 'ginger',
  CatColoration.black: 'black',
  CatColoration.gray: 'gray',
  CatColoration.white: 'white',
  CatColoration.brown: 'brown',
  CatColoration.tricolor: 'tricolor',
  CatColoration.tabby: 'tabby',
};

const _$CharacterEnumMap = {
  Character.calm: 'calm',
  Character.playful: 'playful',
  Character.curious: 'curious',
  Character.capricious: 'capricious',
  Character.lazy: 'lazy',
};
