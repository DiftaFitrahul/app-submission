import 'package:dartz/dartz.dart';

import '../../../../network/exceptions.dart';
import '../../../../network/failure.dart';
import '../../../user/shared/data/data_source/local_data.dart';
import '../data_source/story_data_source.dart';
import '../model/detail_story_data.dart';
import '../model/all_story_data.dart';

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
  Future<Either<Failure, AllStoryData>> getStory(
      {required int page, required int size});
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
            imageBytes: imageBytes,
            lat: lat,
            lon: lon);
        if (addStoryDataResult) {
          return Left(ServerFailure(message: "Error occured!!"));
        }

        return Right(addStoryDataResult);
      } else {
        return Left(ServerFailure(message: "Error occured!!"));
      }
    } catch (err) {
      switch (err) {
        case ClientExceptions():
          return Left(ClientFailure(message: err.message ?? "Error occured!!"));
        default:
          return Left(ServerFailure(message: "Error occured!!"));
      }
    }
  }

  @override
  Future<Either<Failure, AllStoryData>> getStory(
      {required int page, required int size}) async {
    try {
      final token = await _localDataSorce.userToken;
      if (token != null) {
        final getAllStoryResult = await _storyDataSource.getStory(
            token: token, page: page, size: size);
        return Right(getAllStoryResult);
      } else {
        return Left(ServerFailure(message: "Error occured!!"));
      }
    } on ClientExceptions catch (err) {
      return Left(ClientFailure(message: err.message ?? "Error occured!!"));
    } catch (err) {
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
    } on ClientExceptions catch (err) {
      return Left(ClientFailure(message: err.message ?? "Error occured!!"));
    } catch (err) {
      return Left(ServerFailure(message: "Error occured!!"));
    }
  }
}
