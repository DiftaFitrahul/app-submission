part of "story_bloc.dart";

enum StoryStateStatus {
  initial,
  loading,
  success,
  failure,
}

class StoryState {
  final AllStoryData allStoryData;
  final StoryStateStatus stateStatus;
  final DetailStoryData detailStoryData;
  final String message;

  const StoryState(
      {required this.allStoryData,
      required this.detailStoryData,
      required this.stateStatus,
      required this.message});
  factory StoryState.initial() {
    return const StoryState(
        allStoryData: AllStoryData(),
        detailStoryData: DetailStoryData(),
        stateStatus: StoryStateStatus.initial,
        message: "");
  }
  StoryState copyWith(
      {AllStoryData? allStoryData,
      DetailStoryData? detailStoryData,
      StoryStateStatus? stateStatus,
      String? message}) {
    return StoryState(
      allStoryData: allStoryData ?? this.allStoryData,
      detailStoryData: detailStoryData ?? this.detailStoryData,
      stateStatus: stateStatus ?? this.stateStatus,
      message: message ?? this.message,
    );
  }
}
