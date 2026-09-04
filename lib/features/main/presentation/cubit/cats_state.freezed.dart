// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cats_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatsState()';
}


}

/// @nodoc
class $CatsStateCopyWith<$Res>  {
$CatsStateCopyWith(CatsState _, $Res Function(CatsState) __);
}


/// Adds pattern-matching-related methods to [CatsState].
extension CatsStatePatterns on CatsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CatsInitial value)?  initial,TResult Function( CatsLoading value)?  loading,TResult Function( CatsLoadedData value)?  loadedData,TResult Function( CatsError value)?  error,TResult Function( CatsAdding value)?  adding,TResult Function( CatsAdded value)?  added,TResult Function( CatsSelected value)?  selected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CatsInitial() when initial != null:
return initial(_that);case CatsLoading() when loading != null:
return loading(_that);case CatsLoadedData() when loadedData != null:
return loadedData(_that);case CatsError() when error != null:
return error(_that);case CatsAdding() when adding != null:
return adding(_that);case CatsAdded() when added != null:
return added(_that);case CatsSelected() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CatsInitial value)  initial,required TResult Function( CatsLoading value)  loading,required TResult Function( CatsLoadedData value)  loadedData,required TResult Function( CatsError value)  error,required TResult Function( CatsAdding value)  adding,required TResult Function( CatsAdded value)  added,required TResult Function( CatsSelected value)  selected,}){
final _that = this;
switch (_that) {
case CatsInitial():
return initial(_that);case CatsLoading():
return loading(_that);case CatsLoadedData():
return loadedData(_that);case CatsError():
return error(_that);case CatsAdding():
return adding(_that);case CatsAdded():
return added(_that);case CatsSelected():
return selected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CatsInitial value)?  initial,TResult? Function( CatsLoading value)?  loading,TResult? Function( CatsLoadedData value)?  loadedData,TResult? Function( CatsError value)?  error,TResult? Function( CatsAdding value)?  adding,TResult? Function( CatsAdded value)?  added,TResult? Function( CatsSelected value)?  selected,}){
final _that = this;
switch (_that) {
case CatsInitial() when initial != null:
return initial(_that);case CatsLoading() when loading != null:
return loading(_that);case CatsLoadedData() when loadedData != null:
return loadedData(_that);case CatsError() when error != null:
return error(_that);case CatsAdding() when adding != null:
return adding(_that);case CatsAdded() when added != null:
return added(_that);case CatsSelected() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CatModel> cats,  CatModel? selectedCat)?  loadedData,TResult Function( String error)?  error,TResult Function()?  adding,TResult Function()?  added,TResult Function()?  selected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CatsInitial() when initial != null:
return initial();case CatsLoading() when loading != null:
return loading();case CatsLoadedData() when loadedData != null:
return loadedData(_that.cats,_that.selectedCat);case CatsError() when error != null:
return error(_that.error);case CatsAdding() when adding != null:
return adding();case CatsAdded() when added != null:
return added();case CatsSelected() when selected != null:
return selected();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CatModel> cats,  CatModel? selectedCat)  loadedData,required TResult Function( String error)  error,required TResult Function()  adding,required TResult Function()  added,required TResult Function()  selected,}) {final _that = this;
switch (_that) {
case CatsInitial():
return initial();case CatsLoading():
return loading();case CatsLoadedData():
return loadedData(_that.cats,_that.selectedCat);case CatsError():
return error(_that.error);case CatsAdding():
return adding();case CatsAdded():
return added();case CatsSelected():
return selected();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CatModel> cats,  CatModel? selectedCat)?  loadedData,TResult? Function( String error)?  error,TResult? Function()?  adding,TResult? Function()?  added,TResult? Function()?  selected,}) {final _that = this;
switch (_that) {
case CatsInitial() when initial != null:
return initial();case CatsLoading() when loading != null:
return loading();case CatsLoadedData() when loadedData != null:
return loadedData(_that.cats,_that.selectedCat);case CatsError() when error != null:
return error(_that.error);case CatsAdding() when adding != null:
return adding();case CatsAdded() when added != null:
return added();case CatsSelected() when selected != null:
return selected();case _:
  return null;

}
}

}

/// @nodoc


class CatsInitial implements CatsState {
  const CatsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatsState.initial()';
}


}




/// @nodoc


class CatsLoading implements CatsState {
  const CatsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatsState.loading()';
}


}




/// @nodoc


class CatsLoadedData implements CatsState {
  const CatsLoadedData({required final  List<CatModel> cats, this.selectedCat}): _cats = cats;
  

 final  List<CatModel> _cats;
 List<CatModel> get cats {
  if (_cats is EqualUnmodifiableListView) return _cats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cats);
}

 final  CatModel? selectedCat;

/// Create a copy of CatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatsLoadedDataCopyWith<CatsLoadedData> get copyWith => _$CatsLoadedDataCopyWithImpl<CatsLoadedData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsLoadedData&&const DeepCollectionEquality().equals(other._cats, _cats)&&(identical(other.selectedCat, selectedCat) || other.selectedCat == selectedCat));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cats),selectedCat);

@override
String toString() {
  return 'CatsState.loadedData(cats: $cats, selectedCat: $selectedCat)';
}


}

/// @nodoc
abstract mixin class $CatsLoadedDataCopyWith<$Res> implements $CatsStateCopyWith<$Res> {
  factory $CatsLoadedDataCopyWith(CatsLoadedData value, $Res Function(CatsLoadedData) _then) = _$CatsLoadedDataCopyWithImpl;
@useResult
$Res call({
 List<CatModel> cats, CatModel? selectedCat
});


$CatModelCopyWith<$Res>? get selectedCat;

}
/// @nodoc
class _$CatsLoadedDataCopyWithImpl<$Res>
    implements $CatsLoadedDataCopyWith<$Res> {
  _$CatsLoadedDataCopyWithImpl(this._self, this._then);

  final CatsLoadedData _self;
  final $Res Function(CatsLoadedData) _then;

/// Create a copy of CatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cats = null,Object? selectedCat = freezed,}) {
  return _then(CatsLoadedData(
cats: null == cats ? _self._cats : cats // ignore: cast_nullable_to_non_nullable
as List<CatModel>,selectedCat: freezed == selectedCat ? _self.selectedCat : selectedCat // ignore: cast_nullable_to_non_nullable
as CatModel?,
  ));
}

/// Create a copy of CatsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatModelCopyWith<$Res>? get selectedCat {
    if (_self.selectedCat == null) {
    return null;
  }

  return $CatModelCopyWith<$Res>(_self.selectedCat!, (value) {
    return _then(_self.copyWith(selectedCat: value));
  });
}
}

/// @nodoc


class CatsError implements CatsState {
  const CatsError(this.error);
  

 final  String error;

/// Create a copy of CatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatsErrorCopyWith<CatsError> get copyWith => _$CatsErrorCopyWithImpl<CatsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CatsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $CatsErrorCopyWith<$Res> implements $CatsStateCopyWith<$Res> {
  factory $CatsErrorCopyWith(CatsError value, $Res Function(CatsError) _then) = _$CatsErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$CatsErrorCopyWithImpl<$Res>
    implements $CatsErrorCopyWith<$Res> {
  _$CatsErrorCopyWithImpl(this._self, this._then);

  final CatsError _self;
  final $Res Function(CatsError) _then;

/// Create a copy of CatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CatsError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CatsAdding implements CatsState {
  const CatsAdding();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsAdding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatsState.adding()';
}


}




/// @nodoc


class CatsAdded implements CatsState {
  const CatsAdded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsAdded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatsState.added()';
}


}




/// @nodoc


class CatsSelected implements CatsState {
  const CatsSelected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatsSelected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CatsState.selected()';
}


}




// dart format on
