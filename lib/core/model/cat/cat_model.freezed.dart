// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatModel {

 String get id; String get name; DateTime get createdAt; CatColoration get color; int get dayWithCat; int get dairyEntries; Character? get character;
/// Create a copy of CatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatModelCopyWith<CatModel> get copyWith => _$CatModelCopyWithImpl<CatModel>(this as CatModel, _$identity);

  /// Serializes this CatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.color, color) || other.color == color)&&(identical(other.dayWithCat, dayWithCat) || other.dayWithCat == dayWithCat)&&(identical(other.dairyEntries, dairyEntries) || other.dairyEntries == dairyEntries)&&(identical(other.character, character) || other.character == character));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,color,dayWithCat,dairyEntries,character);

@override
String toString() {
  return 'CatModel(id: $id, name: $name, createdAt: $createdAt, color: $color, dayWithCat: $dayWithCat, dairyEntries: $dairyEntries, character: $character)';
}


}

/// @nodoc
abstract mixin class $CatModelCopyWith<$Res>  {
  factory $CatModelCopyWith(CatModel value, $Res Function(CatModel) _then) = _$CatModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime createdAt, CatColoration color, int dayWithCat, int dairyEntries, Character? character
});




}
/// @nodoc
class _$CatModelCopyWithImpl<$Res>
    implements $CatModelCopyWith<$Res> {
  _$CatModelCopyWithImpl(this._self, this._then);

  final CatModel _self;
  final $Res Function(CatModel) _then;

/// Create a copy of CatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? color = null,Object? dayWithCat = null,Object? dairyEntries = null,Object? character = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as CatColoration,dayWithCat: null == dayWithCat ? _self.dayWithCat : dayWithCat // ignore: cast_nullable_to_non_nullable
as int,dairyEntries: null == dairyEntries ? _self.dairyEntries : dairyEntries // ignore: cast_nullable_to_non_nullable
as int,character: freezed == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as Character?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatModel].
extension CatModelPatterns on CatModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatModel value)  $default,){
final _that = this;
switch (_that) {
case _CatModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatModel value)?  $default,){
final _that = this;
switch (_that) {
case _CatModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DateTime createdAt,  CatColoration color,  int dayWithCat,  int dairyEntries,  Character? character)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatModel() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.color,_that.dayWithCat,_that.dairyEntries,_that.character);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DateTime createdAt,  CatColoration color,  int dayWithCat,  int dairyEntries,  Character? character)  $default,) {final _that = this;
switch (_that) {
case _CatModel():
return $default(_that.id,_that.name,_that.createdAt,_that.color,_that.dayWithCat,_that.dairyEntries,_that.character);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DateTime createdAt,  CatColoration color,  int dayWithCat,  int dairyEntries,  Character? character)?  $default,) {final _that = this;
switch (_that) {
case _CatModel() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.color,_that.dayWithCat,_that.dairyEntries,_that.character);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatModel implements CatModel {
  const _CatModel({required this.id, required this.name, required this.createdAt, required this.color, required this.dayWithCat, required this.dairyEntries, this.character});
  factory _CatModel.fromJson(Map<String, dynamic> json) => _$CatModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  DateTime createdAt;
@override final  CatColoration color;
@override final  int dayWithCat;
@override final  int dairyEntries;
@override final  Character? character;

/// Create a copy of CatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatModelCopyWith<_CatModel> get copyWith => __$CatModelCopyWithImpl<_CatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.color, color) || other.color == color)&&(identical(other.dayWithCat, dayWithCat) || other.dayWithCat == dayWithCat)&&(identical(other.dairyEntries, dairyEntries) || other.dairyEntries == dairyEntries)&&(identical(other.character, character) || other.character == character));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,color,dayWithCat,dairyEntries,character);

@override
String toString() {
  return 'CatModel(id: $id, name: $name, createdAt: $createdAt, color: $color, dayWithCat: $dayWithCat, dairyEntries: $dairyEntries, character: $character)';
}


}

/// @nodoc
abstract mixin class _$CatModelCopyWith<$Res> implements $CatModelCopyWith<$Res> {
  factory _$CatModelCopyWith(_CatModel value, $Res Function(_CatModel) _then) = __$CatModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime createdAt, CatColoration color, int dayWithCat, int dairyEntries, Character? character
});




}
/// @nodoc
class __$CatModelCopyWithImpl<$Res>
    implements _$CatModelCopyWith<$Res> {
  __$CatModelCopyWithImpl(this._self, this._then);

  final _CatModel _self;
  final $Res Function(_CatModel) _then;

/// Create a copy of CatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? color = null,Object? dayWithCat = null,Object? dairyEntries = null,Object? character = freezed,}) {
  return _then(_CatModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as CatColoration,dayWithCat: null == dayWithCat ? _self.dayWithCat : dayWithCat // ignore: cast_nullable_to_non_nullable
as int,dairyEntries: null == dairyEntries ? _self.dairyEntries : dairyEntries // ignore: cast_nullable_to_non_nullable
as int,character: freezed == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as Character?,
  ));
}


}

// dart format on
