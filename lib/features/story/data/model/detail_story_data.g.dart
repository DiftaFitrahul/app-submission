// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_story_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetailStoryDataImpl _$$DetailStoryDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DetailStoryDataImpl(
      err: json['err'] as bool? ?? false,
      message: json['message'] as String? ?? "",
      story: json['story'] == null
          ? const StoryData()
          : StoryData.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DetailStoryDataImplToJson(
        _$DetailStoryDataImpl instance) =>
    <String, dynamic>{
      'err': instance.err,
      'message': instance.message,
      'story': instance.story,
    };
