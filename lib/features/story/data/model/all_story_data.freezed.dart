// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_story_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllStoryData _$AllStoryDataFromJson(Map<String, dynamic> json) {
  return _AllStoryData.fromJson(json);
}

/// @nodoc
mixin _$AllStoryData {
  bool get err => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<StoryData> get listStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllStoryDataCopyWith<AllStoryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllStoryDataCopyWith<$Res> {
  factory $AllStoryDataCopyWith(
          AllStoryData value, $Res Function(AllStoryData) then) =
      _$AllStoryDataCopyWithImpl<$Res, AllStoryData>;
  @useResult
  $Res call({bool err, String message, List<StoryData> listStory});
}

/// @nodoc
class _$AllStoryDataCopyWithImpl<$Res, $Val extends AllStoryData>
    implements $AllStoryDataCopyWith<$Res> {
  _$AllStoryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? err = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_value.copyWith(
      err: null == err
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: null == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllStoryDataImplCopyWith<$Res>
    implements $AllStoryDataCopyWith<$Res> {
  factory _$$AllStoryDataImplCopyWith(
          _$AllStoryDataImpl value, $Res Function(_$AllStoryDataImpl) then) =
      __$$AllStoryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool err, String message, List<StoryData> listStory});
}

/// @nodoc
class __$$AllStoryDataImplCopyWithImpl<$Res>
    extends _$AllStoryDataCopyWithImpl<$Res, _$AllStoryDataImpl>
    implements _$$AllStoryDataImplCopyWith<$Res> {
  __$$AllStoryDataImplCopyWithImpl(
      _$AllStoryDataImpl _value, $Res Function(_$AllStoryDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? err = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_$AllStoryDataImpl(
      err: null == err
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: null == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllStoryDataImpl implements _AllStoryData {
  const _$AllStoryDataImpl(
      {this.err = false,
      this.message = "",
      final List<StoryData> listStory = const []})
      : _listStory = listStory;

  factory _$AllStoryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllStoryDataImplFromJson(json);

  @override
  @JsonKey()
  final bool err;
  @override
  @JsonKey()
  final String message;
  final List<StoryData> _listStory;
  @override
  @JsonKey()
  List<StoryData> get listStory {
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listStory);
  }

  @override
  String toString() {
    return 'AllStoryData(err: $err, message: $message, listStory: $listStory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllStoryDataImpl &&
            (identical(other.err, err) || other.err == err) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, err, message,
      const DeepCollectionEquality().hash(_listStory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllStoryDataImplCopyWith<_$AllStoryDataImpl> get copyWith =>
      __$$AllStoryDataImplCopyWithImpl<_$AllStoryDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllStoryDataImplToJson(
      this,
    );
  }
}

abstract class _AllStoryData implements AllStoryData {
  const factory _AllStoryData(
      {final bool err,
      final String message,
      final List<StoryData> listStory}) = _$AllStoryDataImpl;

  factory _AllStoryData.fromJson(Map<String, dynamic> json) =
      _$AllStoryDataImpl.fromJson;

  @override
  bool get err;
  @override
  String get message;
  @override
  List<StoryData> get listStory;
  @override
  @JsonKey(ignore: true)
  _$$AllStoryDataImplCopyWith<_$AllStoryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
