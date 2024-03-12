import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/features/story/data/model/story_data.dart';
part 'all_story_data.freezed.dart';
part 'all_story_data.g.dart';

@freezed
class AllStoryData with _$AllStoryData {
  const factory AllStoryData({
    @Default(false) bool err,
    @Default("") String message,
    @Default([]) List<StoryData> listStory,
  }) = _AllStoryData;

  factory AllStoryData.fromJson(Map<String, Object?> json) =>
      _$AllStoryDataFromJson(json);
}
