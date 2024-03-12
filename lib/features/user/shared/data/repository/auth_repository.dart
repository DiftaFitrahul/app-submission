import 'package:story_app/features/user/shared/data/data_source/auth_data_source.dart';
import 'package:story_app/features/user/shared/data/data_source/local_data.dart';
import 'package:story_app/features/user/shared/data/model/login_data.dart';
import 'package:dartz/dartz.dart';
import 'package:story_app/utils/exceptions.dart';

import '../../../../../utils/failure.dart';

abstract class AuthRepository {
  final AuthDataSource authDataSource;
  final LocalDataSorce localDataSorce;

  const AuthRepository(
      {required this.authDataSource, required this.localDataSorce});

  Future<Either<Failure, LoginData>> login(
      {required String email, required String password});
  Future<Either<Failure, bool>> register(
      {required String name, required String email, required String password});
}

class AuthRepositoryImp extends AuthRepository {
  AuthRepositoryImp(
      {required super.authDataSource, required super.localDataSorce});

  @override
  Future<Either<Failure, LoginData>> login(
      {required String email, required String password}) async {
    try {
      final loginData =
          await authDataSource.login(email: email, password: password);
      await localDataSorce.saveDataUser(
          userId: loginData.loginResult.userId,
          token: loginData.loginResult.token);
      return Right(loginData);
    } on ServerExceptions {
      return Left(ServerFailure(message: "Login Error"));
    }
  }

  @override
  Future<Either<Failure, bool>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final registerData = await authDataSource.register(
          name: name, email: email, password: password);
      return Right(registerData == "User Created");
    } on ServerExceptions {
      return Left(ServerFailure(message: "Register Error"));
    }
  }
}
