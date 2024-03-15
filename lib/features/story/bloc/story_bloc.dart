import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/compress_image.dart';
import '../data/model/all_story_data.dart';
import '../data/model/detail_story_data.dart';
import '../data/repository/story_repository.dart';

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
            stateStatus: StoryStateStatus.failure, message: failure.message));
      }, (allStoryData) {
        emit(state.copyWith(
            allStoryData: allStoryData, stateStatus: StoryStateStatus.success));
      });
    } catch (_) {
      emit(state.copyWith(
          allStoryData: const AllStoryData(),
          stateStatus: StoryStateStatus.failure,
          message: "Error occured!!"));
    }
  }

  void _onStoryDetailFetched(
      StoryDetailFetched event, Emitter<StoryState> emit) async {
    try {
      emit(state.copyWith(stateDetailStatus: DetailStoryStateStatus.loading));
      final result = await _storyRepository.getDetailStory(id: event.id);
      result.fold((failure) {
        emit(state.copyWith(
            stateDetailStatus: DetailStoryStateStatus.failure,
            message: failure.message));
      }, (detailStoryData) {
        emit(state.copyWith(
            detailStoryData: detailStoryData,
            stateDetailStatus: DetailStoryStateStatus.success));
      });
    } catch (_) {
      emit(state.copyWith(
          detailStoryData: const DetailStoryData(),
          stateDetailStatus: DetailStoryStateStatus.failure,
          message: "Error occured!!"));
    }
  }

  void _onStoryPosted(StoryPosted event, Emitter<StoryState> emit) async {
    try {
      emit(state.copyWith(statePostStatus: PostStoryStateStatus.loading));
      final imageBytes = await compressImage(imageFile: event.imageFile);
      final result = await _storyRepository.addStory(
          description: event.description,
          fileName: event.imageFile.name,
          imageBytes: imageBytes);
      result.fold((failure) {
        emit(state.copyWith(
            statePostStatus: PostStoryStateStatus.failure,
            message: failure.message));
      }, (addStoryData) {
        emit(state.copyWith(statePostStatus: PostStoryStateStatus.success));
      });
    } catch (_) {
      emit(state.copyWith(
          statePostStatus: PostStoryStateStatus.failure,
          message: "Error occured!!"));
    }
  }
}
