part of "story_bloc.dart";

enum StoryStateStatus {
  initial,
  refreshing,
  success,
  failure,
}

enum DetailStoryStateStatus {
  initial,
  loading,
  success,
  failure,
}

enum PostStoryStateStatus {
  initial,
  loading,
  success,
  failure,
}

class StoryState {
  final AllStoryData allStoryData;
  final StoryStateStatus stateStatus;
  final DetailStoryStateStatus stateDetailStatus;
  final PostStoryStateStatus statePostStatus;
  final DetailStoryData detailStoryData;
  final bool hasReachedMaxGetStory;
  final String message;

  const StoryState(
      {required this.allStoryData,
      required this.detailStoryData,
      required this.stateStatus,
      required this.statePostStatus,
      required this.message,
      required this.stateDetailStatus,
      required this.hasReachedMaxGetStory});
  factory StoryState.initial() {
    return const StoryState(
        allStoryData: AllStoryData(),
        detailStoryData: DetailStoryData(),
        stateStatus: StoryStateStatus.initial,
        stateDetailStatus: DetailStoryStateStatus.initial,
        statePostStatus: PostStoryStateStatus.initial,
        hasReachedMaxGetStory: false,
        message: "");
  }
  StoryState copyWith(
      {AllStoryData? allStoryData,
      DetailStoryData? detailStoryData,
      StoryStateStatus? stateStatus,
      DetailStoryStateStatus? stateDetailStatus,
      PostStoryStateStatus? statePostStatus,
      bool? hasReachedMaxGetStory,
      String? message}) {
    return StoryState(
      allStoryData: allStoryData ?? this.allStoryData,
      detailStoryData: detailStoryData ?? this.detailStoryData,
      stateStatus: stateStatus ?? this.stateStatus,
      stateDetailStatus: stateDetailStatus ?? this.stateDetailStatus,
      statePostStatus: statePostStatus ?? this.statePostStatus,
      hasReachedMaxGetStory:
          hasReachedMaxGetStory ?? this.hasReachedMaxGetStory,
      message: message ?? this.message,
    );
  }
}
