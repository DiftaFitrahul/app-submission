// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_story_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DetailStoryData _$DetailStoryDataFromJson(Map<String, dynamic> json) {
  return _DetailStoryData.fromJson(json);
}

/// @nodoc
mixin _$DetailStoryData {
  bool get err => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  StoryData get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailStoryDataCopyWith<DetailStoryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailStoryDataCopyWith<$Res> {
  factory $DetailStoryDataCopyWith(
          DetailStoryData value, $Res Function(DetailStoryData) then) =
      _$DetailStoryDataCopyWithImpl<$Res, DetailStoryData>;
  @useResult
  $Res call({bool err, String message, StoryData story});

  $StoryDataCopyWith<$Res> get story;
}

/// @nodoc
class _$DetailStoryDataCopyWithImpl<$Res, $Val extends DetailStoryData>
    implements $DetailStoryDataCopyWith<$Res> {
  _$DetailStoryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? err = null,
    Object? message = null,
    Object? story = null,
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
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as StoryData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryDataCopyWith<$Res> get story {
    return $StoryDataCopyWith<$Res>(_value.story, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailStoryDataImplCopyWith<$Res>
    implements $DetailStoryDataCopyWith<$Res> {
  factory _$$DetailStoryDataImplCopyWith(_$DetailStoryDataImpl value,
          $Res Function(_$DetailStoryDataImpl) then) =
      __$$DetailStoryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool err, String message, StoryData story});

  @override
  $StoryDataCopyWith<$Res> get story;
}

/// @nodoc
class __$$DetailStoryDataImplCopyWithImpl<$Res>
    extends _$DetailStoryDataCopyWithImpl<$Res, _$DetailStoryDataImpl>
    implements _$$DetailStoryDataImplCopyWith<$Res> {
  __$$DetailStoryDataImplCopyWithImpl(
      _$DetailStoryDataImpl _value, $Res Function(_$DetailStoryDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? err = null,
    Object? message = null,
    Object? story = null,
  }) {
    return _then(_$DetailStoryDataImpl(
      err: null == err
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as StoryData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailStoryDataImpl implements _DetailStoryData {
  const _$DetailStoryDataImpl(
      {this.err = false, this.message = "", this.story = const StoryData()});

  factory _$DetailStoryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailStoryDataImplFromJson(json);

  @override
  @JsonKey()
  final bool err;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final StoryData story;

  @override
  String toString() {
    return 'DetailStoryData(err: $err, message: $message, story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailStoryDataImpl &&
            (identical(other.err, err) || other.err == err) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, err, message, story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailStoryDataImplCopyWith<_$DetailStoryDataImpl> get copyWith =>
      __$$DetailStoryDataImplCopyWithImpl<_$DetailStoryDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailStoryDataImplToJson(
      this,
    );
  }
}

abstract class _DetailStoryData implements DetailStoryData {
  const factory _DetailStoryData(
      {final bool err,
      final String message,
      final StoryData story}) = _$DetailStoryDataImpl;

  factory _DetailStoryData.fromJson(Map<String, dynamic> json) =
      _$DetailStoryDataImpl.fromJson;

  @override
  bool get err;
  @override
  String get message;
  @override
  StoryData get story;
  @override
  @JsonKey(ignore: true)
  _$$DetailStoryDataImplCopyWith<_$DetailStoryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
