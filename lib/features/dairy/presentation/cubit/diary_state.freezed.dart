// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiaryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState()';
}


}

/// @nodoc
class $DiaryStateCopyWith<$Res>  {
$DiaryStateCopyWith(DiaryState _, $Res Function(DiaryState) __);
}


/// Adds pattern-matching-related methods to [DiaryState].
extension DiaryStatePatterns on DiaryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DiaryInitial value)?  initial,TResult Function( DiaryLoading value)?  loading,TResult Function( DiaryLoadedData value)?  loadedData,TResult Function( DiaryError value)?  error,TResult Function( DiaryAdding value)?  adding,TResult Function( DiaryAdded value)?  added,TResult Function( DiaryEditing value)?  editing,TResult Function( DiaryEdited value)?  edited,TResult Function( DiaryDeleted value)?  deleted,TResult Function( DiarySelected value)?  selected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DiaryInitial() when initial != null:
return initial(_that);case DiaryLoading() when loading != null:
return loading(_that);case DiaryLoadedData() when loadedData != null:
return loadedData(_that);case DiaryError() when error != null:
return error(_that);case DiaryAdding() when adding != null:
return adding(_that);case DiaryAdded() when added != null:
return added(_that);case DiaryEditing() when editing != null:
return editing(_that);case DiaryEdited() when edited != null:
return edited(_that);case DiaryDeleted() when deleted != null:
return deleted(_that);case DiarySelected() when selected != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DiaryInitial value)  initial,required TResult Function( DiaryLoading value)  loading,required TResult Function( DiaryLoadedData value)  loadedData,required TResult Function( DiaryError value)  error,required TResult Function( DiaryAdding value)  adding,required TResult Function( DiaryAdded value)  added,required TResult Function( DiaryEditing value)  editing,required TResult Function( DiaryEdited value)  edited,required TResult Function( DiaryDeleted value)  deleted,required TResult Function( DiarySelected value)  selected,}){
final _that = this;
switch (_that) {
case DiaryInitial():
return initial(_that);case DiaryLoading():
return loading(_that);case DiaryLoadedData():
return loadedData(_that);case DiaryError():
return error(_that);case DiaryAdding():
return adding(_that);case DiaryAdded():
return added(_that);case DiaryEditing():
return editing(_that);case DiaryEdited():
return edited(_that);case DiaryDeleted():
return deleted(_that);case DiarySelected():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DiaryInitial value)?  initial,TResult? Function( DiaryLoading value)?  loading,TResult? Function( DiaryLoadedData value)?  loadedData,TResult? Function( DiaryError value)?  error,TResult? Function( DiaryAdding value)?  adding,TResult? Function( DiaryAdded value)?  added,TResult? Function( DiaryEditing value)?  editing,TResult? Function( DiaryEdited value)?  edited,TResult? Function( DiaryDeleted value)?  deleted,TResult? Function( DiarySelected value)?  selected,}){
final _that = this;
switch (_that) {
case DiaryInitial() when initial != null:
return initial(_that);case DiaryLoading() when loading != null:
return loading(_that);case DiaryLoadedData() when loadedData != null:
return loadedData(_that);case DiaryError() when error != null:
return error(_that);case DiaryAdding() when adding != null:
return adding(_that);case DiaryAdded() when added != null:
return added(_that);case DiaryEditing() when editing != null:
return editing(_that);case DiaryEdited() when edited != null:
return edited(_that);case DiaryDeleted() when deleted != null:
return deleted(_that);case DiarySelected() when selected != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<DiaryModel> diaryEntries)?  loadedData,TResult Function( String error)?  error,TResult Function()?  adding,TResult Function()?  added,TResult Function()?  editing,TResult Function()?  edited,TResult Function()?  deleted,TResult Function()?  selected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DiaryInitial() when initial != null:
return initial();case DiaryLoading() when loading != null:
return loading();case DiaryLoadedData() when loadedData != null:
return loadedData(_that.diaryEntries);case DiaryError() when error != null:
return error(_that.error);case DiaryAdding() when adding != null:
return adding();case DiaryAdded() when added != null:
return added();case DiaryEditing() when editing != null:
return editing();case DiaryEdited() when edited != null:
return edited();case DiaryDeleted() when deleted != null:
return deleted();case DiarySelected() when selected != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<DiaryModel> diaryEntries)  loadedData,required TResult Function( String error)  error,required TResult Function()  adding,required TResult Function()  added,required TResult Function()  editing,required TResult Function()  edited,required TResult Function()  deleted,required TResult Function()  selected,}) {final _that = this;
switch (_that) {
case DiaryInitial():
return initial();case DiaryLoading():
return loading();case DiaryLoadedData():
return loadedData(_that.diaryEntries);case DiaryError():
return error(_that.error);case DiaryAdding():
return adding();case DiaryAdded():
return added();case DiaryEditing():
return editing();case DiaryEdited():
return edited();case DiaryDeleted():
return deleted();case DiarySelected():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<DiaryModel> diaryEntries)?  loadedData,TResult? Function( String error)?  error,TResult? Function()?  adding,TResult? Function()?  added,TResult? Function()?  editing,TResult? Function()?  edited,TResult? Function()?  deleted,TResult? Function()?  selected,}) {final _that = this;
switch (_that) {
case DiaryInitial() when initial != null:
return initial();case DiaryLoading() when loading != null:
return loading();case DiaryLoadedData() when loadedData != null:
return loadedData(_that.diaryEntries);case DiaryError() when error != null:
return error(_that.error);case DiaryAdding() when adding != null:
return adding();case DiaryAdded() when added != null:
return added();case DiaryEditing() when editing != null:
return editing();case DiaryEdited() when edited != null:
return edited();case DiaryDeleted() when deleted != null:
return deleted();case DiarySelected() when selected != null:
return selected();case _:
  return null;

}
}

}

/// @nodoc


class DiaryInitial implements DiaryState {
  const DiaryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.initial()';
}


}




/// @nodoc


class DiaryLoading implements DiaryState {
  const DiaryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.loading()';
}


}




/// @nodoc


class DiaryLoadedData implements DiaryState {
  const DiaryLoadedData({required final  List<DiaryModel> diaryEntries}): _diaryEntries = diaryEntries;
  

 final  List<DiaryModel> _diaryEntries;
 List<DiaryModel> get diaryEntries {
  if (_diaryEntries is EqualUnmodifiableListView) return _diaryEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diaryEntries);
}


/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryLoadedDataCopyWith<DiaryLoadedData> get copyWith => _$DiaryLoadedDataCopyWithImpl<DiaryLoadedData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryLoadedData&&const DeepCollectionEquality().equals(other._diaryEntries, _diaryEntries));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_diaryEntries));

@override
String toString() {
  return 'DiaryState.loadedData(diaryEntries: $diaryEntries)';
}


}

/// @nodoc
abstract mixin class $DiaryLoadedDataCopyWith<$Res> implements $DiaryStateCopyWith<$Res> {
  factory $DiaryLoadedDataCopyWith(DiaryLoadedData value, $Res Function(DiaryLoadedData) _then) = _$DiaryLoadedDataCopyWithImpl;
@useResult
$Res call({
 List<DiaryModel> diaryEntries
});




}
/// @nodoc
class _$DiaryLoadedDataCopyWithImpl<$Res>
    implements $DiaryLoadedDataCopyWith<$Res> {
  _$DiaryLoadedDataCopyWithImpl(this._self, this._then);

  final DiaryLoadedData _self;
  final $Res Function(DiaryLoadedData) _then;

/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? diaryEntries = null,}) {
  return _then(DiaryLoadedData(
diaryEntries: null == diaryEntries ? _self._diaryEntries : diaryEntries // ignore: cast_nullable_to_non_nullable
as List<DiaryModel>,
  ));
}


}

/// @nodoc


class DiaryError implements DiaryState {
  const DiaryError(this.error);
  

 final  String error;

/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryErrorCopyWith<DiaryError> get copyWith => _$DiaryErrorCopyWithImpl<DiaryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'DiaryState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $DiaryErrorCopyWith<$Res> implements $DiaryStateCopyWith<$Res> {
  factory $DiaryErrorCopyWith(DiaryError value, $Res Function(DiaryError) _then) = _$DiaryErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$DiaryErrorCopyWithImpl<$Res>
    implements $DiaryErrorCopyWith<$Res> {
  _$DiaryErrorCopyWithImpl(this._self, this._then);

  final DiaryError _self;
  final $Res Function(DiaryError) _then;

/// Create a copy of DiaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(DiaryError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DiaryAdding implements DiaryState {
  const DiaryAdding();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryAdding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.adding()';
}


}




/// @nodoc


class DiaryAdded implements DiaryState {
  const DiaryAdded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryAdded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.added()';
}


}




/// @nodoc


class DiaryEditing implements DiaryState {
  const DiaryEditing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryEditing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.editing()';
}


}




/// @nodoc


class DiaryEdited implements DiaryState {
  const DiaryEdited();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryEdited);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.edited()';
}


}




/// @nodoc


class DiaryDeleted implements DiaryState {
  const DiaryDeleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryDeleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.deleted()';
}


}




/// @nodoc


class DiarySelected implements DiaryState {
  const DiarySelected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiarySelected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DiaryState.selected()';
}


}




// dart format on
