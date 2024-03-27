part of "story_bloc.dart";

sealed class StoryEvent {
  const StoryEvent();
}

final class StoryFetched extends StoryEvent {}

final class StoryRefreshed extends StoryEvent {}

final class StoryDetailFetched extends StoryEvent {
  const StoryDetailFetched({required this.id});
  final String id;
}

final class StoryPosted extends StoryEvent {
  const StoryPosted(
      {required this.description, required this.imageFile, this.lat, this.lon});

  final XFile imageFile;
  final String description;
  final double? lon;
  final double? lat;
}
