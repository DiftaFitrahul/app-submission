import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/features/story/data/model/all_story_data.dart';
import 'package:story_app/features/story/data/model/detail_story_data.dart';
import 'package:story_app/features/story/data/repository/story_repository.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required StoryRepository storyRepository})
      : _storyRepository = storyRepository,
        super(StoryState.initial()) {}

  final StoryRepository _storyRepository;
}
