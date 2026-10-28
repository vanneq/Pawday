// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoodState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FoodState()';
}


}

/// @nodoc
class $FoodStateCopyWith<$Res>  {
$FoodStateCopyWith(FoodState _, $Res Function(FoodState) __);
}


/// Adds pattern-matching-related methods to [FoodState].
extension FoodStatePatterns on FoodState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FoodInitial value)?  initial,TResult Function( FoodLoading value)?  loading,TResult Function( FoodSuccess value)?  success,TResult Function( FoodsLoadedData value)?  loadedData,TResult Function( FoodError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FoodInitial() when initial != null:
return initial(_that);case FoodLoading() when loading != null:
return loading(_that);case FoodSuccess() when success != null:
return success(_that);case FoodsLoadedData() when loadedData != null:
return loadedData(_that);case FoodError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FoodInitial value)  initial,required TResult Function( FoodLoading value)  loading,required TResult Function( FoodSuccess value)  success,required TResult Function( FoodsLoadedData value)  loadedData,required TResult Function( FoodError value)  error,}){
final _that = this;
switch (_that) {
case FoodInitial():
return initial(_that);case FoodLoading():
return loading(_that);case FoodSuccess():
return success(_that);case FoodsLoadedData():
return loadedData(_that);case FoodError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FoodInitial value)?  initial,TResult? Function( FoodLoading value)?  loading,TResult? Function( FoodSuccess value)?  success,TResult? Function( FoodsLoadedData value)?  loadedData,TResult? Function( FoodError value)?  error,}){
final _that = this;
switch (_that) {
case FoodInitial() when initial != null:
return initial(_that);case FoodLoading() when loading != null:
return loading(_that);case FoodSuccess() when success != null:
return success(_that);case FoodsLoadedData() when loadedData != null:
return loadedData(_that);case FoodError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( Map<FoodType, int> inventory,  bool isOperationProgress)?  loadedData,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FoodInitial() when initial != null:
return initial();case FoodLoading() when loading != null:
return loading();case FoodSuccess() when success != null:
return success();case FoodsLoadedData() when loadedData != null:
return loadedData(_that.inventory,_that.isOperationProgress);case FoodError() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( Map<FoodType, int> inventory,  bool isOperationProgress)  loadedData,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case FoodInitial():
return initial();case FoodLoading():
return loading();case FoodSuccess():
return success();case FoodsLoadedData():
return loadedData(_that.inventory,_that.isOperationProgress);case FoodError():
return error(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( Map<FoodType, int> inventory,  bool isOperationProgress)?  loadedData,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case FoodInitial() when initial != null:
return initial();case FoodLoading() when loading != null:
return loading();case FoodSuccess() when success != null:
return success();case FoodsLoadedData() when loadedData != null:
return loadedData(_that.inventory,_that.isOperationProgress);case FoodError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class FoodInitial implements FoodState {
  const FoodInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FoodState.initial()';
}


}




/// @nodoc


class FoodLoading implements FoodState {
  const FoodLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FoodState.loading()';
}


}




/// @nodoc


class FoodSuccess implements FoodState {
  const FoodSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FoodState.success()';
}


}




/// @nodoc


class FoodsLoadedData implements FoodState {
  const FoodsLoadedData({required final  Map<FoodType, int> inventory, required this.isOperationProgress}): _inventory = inventory;
  

 final  Map<FoodType, int> _inventory;
 Map<FoodType, int> get inventory {
  if (_inventory is EqualUnmodifiableMapView) return _inventory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_inventory);
}

 final  bool isOperationProgress;

/// Create a copy of FoodState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodsLoadedDataCopyWith<FoodsLoadedData> get copyWith => _$FoodsLoadedDataCopyWithImpl<FoodsLoadedData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodsLoadedData&&const DeepCollectionEquality().equals(other._inventory, _inventory)&&(identical(other.isOperationProgress, isOperationProgress) || other.isOperationProgress == isOperationProgress));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_inventory),isOperationProgress);

@override
String toString() {
  return 'FoodState.loadedData(inventory: $inventory, isOperationProgress: $isOperationProgress)';
}


}

/// @nodoc
abstract mixin class $FoodsLoadedDataCopyWith<$Res> implements $FoodStateCopyWith<$Res> {
  factory $FoodsLoadedDataCopyWith(FoodsLoadedData value, $Res Function(FoodsLoadedData) _then) = _$FoodsLoadedDataCopyWithImpl;
@useResult
$Res call({
 Map<FoodType, int> inventory, bool isOperationProgress
});




}
/// @nodoc
class _$FoodsLoadedDataCopyWithImpl<$Res>
    implements $FoodsLoadedDataCopyWith<$Res> {
  _$FoodsLoadedDataCopyWithImpl(this._self, this._then);

  final FoodsLoadedData _self;
  final $Res Function(FoodsLoadedData) _then;

/// Create a copy of FoodState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inventory = null,Object? isOperationProgress = null,}) {
  return _then(FoodsLoadedData(
inventory: null == inventory ? _self._inventory : inventory // ignore: cast_nullable_to_non_nullable
as Map<FoodType, int>,isOperationProgress: null == isOperationProgress ? _self.isOperationProgress : isOperationProgress // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class FoodError implements FoodState {
  const FoodError(this.error);
  

 final  String error;

/// Create a copy of FoodState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodErrorCopyWith<FoodError> get copyWith => _$FoodErrorCopyWithImpl<FoodError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'FoodState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $FoodErrorCopyWith<$Res> implements $FoodStateCopyWith<$Res> {
  factory $FoodErrorCopyWith(FoodError value, $Res Function(FoodError) _then) = _$FoodErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$FoodErrorCopyWithImpl<$Res>
    implements $FoodErrorCopyWith<$Res> {
  _$FoodErrorCopyWithImpl(this._self, this._then);

  final FoodError _self;
  final $Res Function(FoodError) _then;

/// Create a copy of FoodState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(FoodError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
