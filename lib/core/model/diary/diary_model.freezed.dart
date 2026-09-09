// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiaryModel {

 String get id; String get catId; String? get imageUrl; DateTime get createdAt; String get description; CatMood get mood;
/// Create a copy of DiaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryModelCopyWith<DiaryModel> get copyWith => _$DiaryModelCopyWithImpl<DiaryModel>(this as DiaryModel, _$identity);

  /// Serializes this DiaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.catId, catId) || other.catId == catId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.mood, mood) || other.mood == mood));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,catId,imageUrl,createdAt,description,mood);

@override
String toString() {
  return 'DiaryModel(id: $id, catId: $catId, imageUrl: $imageUrl, createdAt: $createdAt, description: $description, mood: $mood)';
}


}

/// @nodoc
abstract mixin class $DiaryModelCopyWith<$Res>  {
  factory $DiaryModelCopyWith(DiaryModel value, $Res Function(DiaryModel) _then) = _$DiaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String catId, String? imageUrl, DateTime createdAt, String description, CatMood mood
});




}
/// @nodoc
class _$DiaryModelCopyWithImpl<$Res>
    implements $DiaryModelCopyWith<$Res> {
  _$DiaryModelCopyWithImpl(this._self, this._then);

  final DiaryModel _self;
  final $Res Function(DiaryModel) _then;

/// Create a copy of DiaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? catId = null,Object? imageUrl = freezed,Object? createdAt = null,Object? description = null,Object? mood = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,catId: null == catId ? _self.catId : catId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as CatMood,
  ));
}

}


/// Adds pattern-matching-related methods to [DiaryModel].
extension DiaryModelPatterns on DiaryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryModel value)  $default,){
final _that = this;
switch (_that) {
case _DiaryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String catId,  String? imageUrl,  DateTime createdAt,  String description,  CatMood mood)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryModel() when $default != null:
return $default(_that.id,_that.catId,_that.imageUrl,_that.createdAt,_that.description,_that.mood);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String catId,  String? imageUrl,  DateTime createdAt,  String description,  CatMood mood)  $default,) {final _that = this;
switch (_that) {
case _DiaryModel():
return $default(_that.id,_that.catId,_that.imageUrl,_that.createdAt,_that.description,_that.mood);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String catId,  String? imageUrl,  DateTime createdAt,  String description,  CatMood mood)?  $default,) {final _that = this;
switch (_that) {
case _DiaryModel() when $default != null:
return $default(_that.id,_that.catId,_that.imageUrl,_that.createdAt,_that.description,_that.mood);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiaryModel implements DiaryModel {
  const _DiaryModel({required this.id, required this.catId, this.imageUrl, required this.createdAt, required this.description, required this.mood});
  factory _DiaryModel.fromJson(Map<String, dynamic> json) => _$DiaryModelFromJson(json);

@override final  String id;
@override final  String catId;
@override final  String? imageUrl;
@override final  DateTime createdAt;
@override final  String description;
@override final  CatMood mood;

/// Create a copy of DiaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryModelCopyWith<_DiaryModel> get copyWith => __$DiaryModelCopyWithImpl<_DiaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.catId, catId) || other.catId == catId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.mood, mood) || other.mood == mood));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,catId,imageUrl,createdAt,description,mood);

@override
String toString() {
  return 'DiaryModel(id: $id, catId: $catId, imageUrl: $imageUrl, createdAt: $createdAt, description: $description, mood: $mood)';
}


}

/// @nodoc
abstract mixin class _$DiaryModelCopyWith<$Res> implements $DiaryModelCopyWith<$Res> {
  factory _$DiaryModelCopyWith(_DiaryModel value, $Res Function(_DiaryModel) _then) = __$DiaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String catId, String? imageUrl, DateTime createdAt, String description, CatMood mood
});




}
/// @nodoc
class __$DiaryModelCopyWithImpl<$Res>
    implements _$DiaryModelCopyWith<$Res> {
  __$DiaryModelCopyWithImpl(this._self, this._then);

  final _DiaryModel _self;
  final $Res Function(_DiaryModel) _then;

/// Create a copy of DiaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? catId = null,Object? imageUrl = freezed,Object? createdAt = null,Object? description = null,Object? mood = null,}) {
  return _then(_DiaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,catId: null == catId ? _self.catId : catId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as CatMood,
  ));
}


}

// dart format on
