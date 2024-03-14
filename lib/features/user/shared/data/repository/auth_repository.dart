import 'package:dartz/dartz.dart';

import '../../../../../network/failure.dart';
import '../../../../../network/exceptions.dart';
import '../data_source/auth_data_source.dart';
import '../data_source/local_data.dart';
import '../model/login_data.dart';

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
  Future<Either<Failure, String>> register(
      {required String name, required String email, required String password});
  Future<void> logout();
  Future<bool> checkUserAuth();
}

class AuthRepositoryImp extends AuthRepository {
  const AuthRepositoryImp(
      {required super.authDataSource, required super.localDataSorce});

  @override
  Future<bool> checkUserAuth() async {
    final userToken = await _localDataSorce.userToken;
    final isUserAuthenticated = userToken?.isNotEmpty ?? false;
    return isUserAuthenticated;
  }

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
  Future<Either<Failure, String>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final errorResult = await _authDataSource.register(
          name: name, email: email, password: password);

      return Right(errorResult);
    } on DataExceptions catch (err) {
      return Left(ServerFailure(message: err.message ?? "Error Occured!!"));
    } on ServerExceptions {
      return Left(ServerFailure(message: "Register Error"));
    }
  }

  @override
  Future<void> logout() async {
    _localDataSorce.deleteDataUser();
  }
}
