import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../utils/compress_image.dart';
import '../data/model/all_story_data.dart';
import '../data/model/detail_story_data.dart';
import '../data/repository/story_repository.dart';

part 'story_event.dart';
part 'story_state.dart';

const _sizeLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required StoryRepository storyRepository})
      : _storyRepository = storyRepository,
        super(StoryState.initial()) {
    on<StoryFetched>(_onStoryFetched,
        transformer: throttleDroppable(throttleDuration));
    on<StoryRefreshed>(_onStoryRefreshed);
    on<StoryDetailFetched>(_onStoryDetailFetched);
    on<StoryPosted>(_onStoryPosted);
  }

  final StoryRepository _storyRepository;
  int _currentPage = 1;

  void _onStoryFetched(StoryFetched event, Emitter<StoryState> emit) async {
    if (state.hasReachedMaxGetStory) return;
    try {
      final result =
          await _storyRepository.getStory(page: _currentPage, size: _sizeLimit);

      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: StoryStateStatus.failure, message: failure.message));
      }, (allStoryData) {
        _currentPage += 1;

        final bool hasReachedMax = allStoryData.listStory.length < _sizeLimit;
        final newAllStoryData = state.allStoryData.copyWith(
            listStory: List.of(state.allStoryData.listStory)
              ..addAll(allStoryData.listStory));
        emit(state.copyWith(
          allStoryData: newAllStoryData,
          hasReachedMaxGetStory: hasReachedMax,
          stateStatus: StoryStateStatus.success,
        ));
      });
    } catch (_) {
      emit(state.copyWith(
          allStoryData: const AllStoryData(),
          stateStatus: StoryStateStatus.failure,
          message: "Error occured!!"));
    }
  }

  void _onStoryRefreshed(StoryRefreshed event, Emitter<StoryState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StoryStateStatus.refreshing));
      final result = await _storyRepository.getStory(page: 1, size: _sizeLimit);

      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: StoryStateStatus.failure, message: failure.message));
      }, (allStoryData) {
        _currentPage = 1;
        emit(state.copyWith(
          allStoryData: allStoryData,
          hasReachedMaxGetStory: false,
          stateStatus: StoryStateStatus.success,
        ));
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
