import 'package:dartz/dartz.dart';
import 'package:story_app/features/story/data/data_source/story_data_source.dart';
import 'package:story_app/features/story/data/model/all_story_data.dart';
import 'package:story_app/features/story/data/model/detail_story_data.dart';
import 'package:story_app/features/user/shared/data/data_source/local_data.dart';

import '../../../../utils/failure.dart';

abstract class StoryRepository {
  final StoryDataSource _storyDataSource;
  final LocalDataSource _localDataSorce;

  const StoryRepository(
      {required StoryDataSource storyDataSource,
      required LocalDataSource localDataSource})
      : _storyDataSource = storyDataSource,
        _localDataSorce = localDataSource;

  Future<Either<Failure, bool>> addStory(
      {required String description,
      required List<int> imageBytes,
      required String fileName,
      double? lat,
      double? lon});
  Future<Either<Failure, AllStoryData>> getAllStory();
  Future<Either<Failure, DetailStoryData>> getDetailStory({required String id});
}

class StoryRepositoryImp extends StoryRepository {
  const StoryRepositoryImp(
      {required super.localDataSource, required super.storyDataSource});
  @override
  Future<Either<Failure, bool>> addStory(
      {required String description,
      required List<int> imageBytes,
      required String fileName,
      double? lat,
      double? lon}) async {
    try {
      final token = await _localDataSorce.userToken;
      if (token != null) {
        final addStoryDataResult = await _storyDataSource.addStory(
            token: token,
            description: description,
            fileName: fileName,
            imageBytes: imageBytes);
        if (!addStoryDataResult) {
          return Left(ServerFailure(message: "Error occured!!"));
        }

        return Right(addStoryDataResult);
      } else {
        return Left(ServerFailure(message: "Error occured!!"));
      }
    } catch (_) {
      return Left(ServerFailure(message: "Error occured!!"));
    }
  }

  @override
  Future<Either<Failure, AllStoryData>> getAllStory() async {
    try {
      final token = await _localDataSorce.userToken;
      if (token != null) {
        final getAllStoryResult =
            await _storyDataSource.getAllStory(token: token);
        return Right(getAllStoryResult);
      } else {
        return Left(ServerFailure(message: "Error occured!!"));
      }
    } catch (_) {
      return Left(ServerFailure(message: "Error occured!!"));
    }
  }

  @override
  Future<Either<Failure, DetailStoryData>> getDetailStory(
      {required String id}) async {
    try {
      final token = await _localDataSorce.userToken;
      if (token != null) {
        final getDetailStoryResult =
            await _storyDataSource.getDetailStory(id: id, token: token);
        return Right(getDetailStoryResult);
      } else {
        return Left(ServerFailure(message: "Error occured!!"));
      }
    } catch (_) {
      return Left(ServerFailure(message: "Error occured!!"));
    }
  }
}
