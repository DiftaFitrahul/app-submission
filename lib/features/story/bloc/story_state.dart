part of "story_bloc.dart";

enum StoryStateStatus {
  initial,
  loading,
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

  final String message;

  const StoryState(
      {required this.allStoryData,
      required this.detailStoryData,
      required this.stateStatus,
      required this.statePostStatus,
      required this.message,
      required this.stateDetailStatus});
  factory StoryState.initial() {
    return const StoryState(
        allStoryData: AllStoryData(),
        detailStoryData: DetailStoryData(),
        stateStatus: StoryStateStatus.initial,
        stateDetailStatus: DetailStoryStateStatus.initial,
        statePostStatus: PostStoryStateStatus.initial,
        message: "");
  }
  StoryState copyWith(
      {AllStoryData? allStoryData,
      DetailStoryData? detailStoryData,
      StoryStateStatus? stateStatus,
      DetailStoryStateStatus? stateDetailStatus,
      PostStoryStateStatus? statePostStatus,
      String? message}) {
    return StoryState(
      allStoryData: allStoryData ?? this.allStoryData,
      detailStoryData: detailStoryData ?? this.detailStoryData,
      stateStatus: stateStatus ?? this.stateStatus,
      stateDetailStatus: stateDetailStatus ?? this.stateDetailStatus,
      statePostStatus: statePostStatus ?? this.statePostStatus,
      message: message ?? this.message,
    );
  }
}
