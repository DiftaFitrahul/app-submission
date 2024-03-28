// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryData _$StoryDataFromJson(Map<String, dynamic> json) {
  return _StoryData.fromJson(json);
}

/// @nodoc
mixin _$StoryData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryDataCopyWith<StoryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDataCopyWith<$Res> {
  factory $StoryDataCopyWith(StoryData value, $Res Function(StoryData) then) =
      _$StoryDataCopyWithImpl<$Res, StoryData>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String photoUrl,
      String createdAt,
      double? lat,
      double? lon});
}

/// @nodoc
class _$StoryDataCopyWithImpl<$Res, $Val extends StoryData>
    implements $StoryDataCopyWith<$Res> {
  _$StoryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? photoUrl = null,
    Object? createdAt = null,
    Object? lat = freezed,
    Object? lon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryDataImplCopyWith<$Res>
    implements $StoryDataCopyWith<$Res> {
  factory _$$StoryDataImplCopyWith(
          _$StoryDataImpl value, $Res Function(_$StoryDataImpl) then) =
      __$$StoryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String photoUrl,
      String createdAt,
      double? lat,
      double? lon});
}

/// @nodoc
class __$$StoryDataImplCopyWithImpl<$Res>
    extends _$StoryDataCopyWithImpl<$Res, _$StoryDataImpl>
    implements _$$StoryDataImplCopyWith<$Res> {
  __$$StoryDataImplCopyWithImpl(
      _$StoryDataImpl _value, $Res Function(_$StoryDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? photoUrl = null,
    Object? createdAt = null,
    Object? lat = freezed,
    Object? lon = freezed,
  }) {
    return _then(_$StoryDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryDataImpl implements _StoryData {
  const _$StoryDataImpl(
      {this.id = "",
      this.name = "",
      this.description = "",
      this.photoUrl = "",
      this.createdAt = "",
      this.lat,
      this.lon});

  factory _$StoryDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryDataImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String photoUrl;
  @override
  @JsonKey()
  final String createdAt;
  @override
  final double? lat;
  @override
  final double? lon;

  @override
  String toString() {
    return 'StoryData(id: $id, name: $name, description: $description, photoUrl: $photoUrl, createdAt: $createdAt, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, photoUrl, createdAt, lat, lon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryDataImplCopyWith<_$StoryDataImpl> get copyWith =>
      __$$StoryDataImplCopyWithImpl<_$StoryDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryDataImplToJson(
      this,
    );
  }
}

abstract class _StoryData implements StoryData {
  const factory _StoryData(
      {final String id,
      final String name,
      final String description,
      final String photoUrl,
      final String createdAt,
      final double? lat,
      final double? lon}) = _$StoryDataImpl;

  factory _StoryData.fromJson(Map<String, dynamic> json) =
      _$StoryDataImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get photoUrl;
  @override
  String get createdAt;
  @override
  double? get lat;
  @override
  double? get lon;
  @override
  @JsonKey(ignore: true)
  _$$StoryDataImplCopyWith<_$StoryDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
