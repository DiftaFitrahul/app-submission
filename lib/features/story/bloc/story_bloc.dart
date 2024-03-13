import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/features/story/data/model/all_story_data.dart';
import 'package:story_app/features/story/data/model/detail_story_data.dart';
import 'package:story_app/features/story/data/repository/story_repository.dart';

import '../../../utils/compress_image.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required StoryRepository storyRepository})
      : _storyRepository = storyRepository,
        super(StoryState.initial()) {
    on<StoryAllFetched>(_onStoryAllFetched);
    on<StoryDetailFetched>(_onStoryDetailFetched);
    on<StoryPosted>(_onStoryPosted);
  }

  final StoryRepository _storyRepository;

  void _onStoryAllFetched(
      StoryAllFetched event, Emitter<StoryState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StoryStateStatus.loading));
      final result = await _storyRepository.getAllStory();
      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: StoryStateStatus.failure, message: "Error occured!!"));
      }, (allStoryData) {
        emit(state.copyWith(
            allStoryData: allStoryData, stateStatus: StoryStateStatus.success));
      });
    } catch (_) {
      emit(state.copyWith(
          stateStatus: StoryStateStatus.failure, message: "Error occured!!"));
    }
  }

  void _onStoryDetailFetched(
      StoryDetailFetched event, Emitter<StoryState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StoryStateStatus.loading));
      final result = await _storyRepository.getDetailStory(id: event.id);
      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: StoryStateStatus.failure, message: "Error occured!!"));
      }, (detailStoryData) {
        emit(state.copyWith(
            detailStoryData: detailStoryData,
            stateStatus: StoryStateStatus.success));
      });
    } catch (_) {
      emit(state.copyWith(
          stateStatus: StoryStateStatus.failure, message: "Error occured!!"));
    }
  }

  void _onStoryPosted(StoryPosted event, Emitter<StoryState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StoryStateStatus.loading));
      final imageBytes = await compressImage(file: event.imageFile);
      final result = await _storyRepository.addStory(
          description: event.description,
          fileName: event.imageFile.name,
          imageBytes: imageBytes);
      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: StoryStateStatus.failure, message: "Error occured!!"));
      }, (addStoryData) {
        emit(state.copyWith(stateStatus: StoryStateStatus.success));
      });
    } catch (_) {
      emit(state.copyWith(
          stateStatus: StoryStateStatus.failure, message: "Error occured!!"));
    }
  }
}
