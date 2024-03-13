import 'dart:developer';

import 'package:story_app/features/user/shared/data/data_source/auth_data_source.dart';
import 'package:story_app/features/user/shared/data/data_source/local_data.dart';
import 'package:story_app/features/user/shared/data/model/login_data.dart';
import 'package:dartz/dartz.dart';
import 'package:story_app/network/exceptions.dart';

import '../../../../../network/failure.dart';

abstract class AuthRepository {
  final AuthDataSource _authDataSource;
  final LocalDataSource _localDataSorce;

  const AuthRepository(
      {required AuthDataSource authDataSource,
      required LocalDataSource localDataSorce})
      : _authDataSource = authDataSource,
        _localDataSorce = localDataSorce;

  Future<Either<Failure, LoginData>> login(
      {required String email, required String password});
  Future<Either<Failure, bool>> register(
      {required String name, required String email, required String password});
  Future<bool> checkUserAuth();
}

class AuthRepositoryImp extends AuthRepository {
  const AuthRepositoryImp(
      {required super.authDataSource, required super.localDataSorce});

  @override
  Future<Either<Failure, LoginData>> login(
      {required String email, required String password}) async {
    try {
      final loginDataSource =
          await _authDataSource.login(email: email, password: password);
      await _localDataSorce.saveDataUser(
          userId: loginDataSource.loginResult.userId,
          token: loginDataSource.loginResult.token);
      return Right(loginDataSource);
    } on DataExceptions catch (err) {
      return Left(ServerFailure(message: err.message ?? "Error Occured!!"));
    } on ServerExceptions {
      return Left(ServerFailure(message: "Error Occured!!"));
    }
  }

  @override
  Future<Either<Failure, bool>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final registerData = await _authDataSource.register(
          name: name, email: email, password: password);
      if (!registerData) return Left(ServerFailure(message: "Register Error"));
      return Right(registerData);
    } on DataExceptions catch (err) {
      return Left(ServerFailure(message: err.message ?? "Error Occured!!"));
    } on ServerExceptions {
      return Left(ServerFailure(message: "Register Error"));
    }
  }

  @override
  Future<bool> checkUserAuth() async {
    final userToken = await _localDataSorce.userToken;
    final isUserAuthenticated = userToken?.isNotEmpty ?? false;
    return isUserAuthenticated;
  }
}
