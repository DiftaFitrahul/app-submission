import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_data.freezed.dart';
part 'story_data.g.dart';

@freezed
class StoryData with _$StoryData {
  const factory StoryData({
    @Default("") String id,
    @Default("") String name,
    @Default("") String description,
    @Default("") String photoUrl,
    @Default("") String createdAt,
    double? lat,
    double? lon,
  }) = _StoryData;
  factory StoryData.fromJson(Map<String, Object?> json) =>
      _$StoryDataFromJson(json);
}
