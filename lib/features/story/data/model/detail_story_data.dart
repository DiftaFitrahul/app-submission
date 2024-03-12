import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/features/story/data/model/story_data.dart';
part 'detail_story_data.freezed.dart';
part 'detail_story_data.g.dart';

@freezed
class DetailStoryData with _$DetailStoryData {
  const factory DetailStoryData({
    @Default(false) bool err,
    @Default("") String message,
    @Default(StoryData()) StoryData story,
  }) = _DetailStoryData;

  factory DetailStoryData.fromJson(Map<String, Object?> json) =>
      _$DetailStoryDataFromJson(json);
}
