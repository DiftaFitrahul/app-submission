// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_story_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllStoryDataImpl _$$AllStoryDataImplFromJson(Map<String, dynamic> json) =>
    _$AllStoryDataImpl(
      err: json['err'] as bool? ?? false,
      message: json['message'] as String? ?? "",
      listStory: (json['listStory'] as List<dynamic>?)
              ?.map((e) => StoryData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AllStoryDataImplToJson(_$AllStoryDataImpl instance) =>
    <String, dynamic>{
      'err': instance.err,
      'message': instance.message,
      'listStory': instance.listStory,
    };
