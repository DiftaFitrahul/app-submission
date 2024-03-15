import '../data_source/local_data.dart';

abstract class UserRepository {
  final LocalDataSource _localDataSorce;

  const UserRepository({required LocalDataSource localDataSorce})
      : _localDataSorce = localDataSorce;

  Future<String> getUserLocalePreferences();
  Future<void> saveUserLocalePreferences(String userLocalePreferences);

  Future<void> deleteUserLocalePreferences();
}

class UserRepositoryImp extends UserRepository {
  const UserRepositoryImp({required super.localDataSorce});

  @override
  Future<String> getUserLocalePreferences() async {
    final userLocalePreferences =
        await _localDataSorce.userLocalePreferences ?? "en";
    return userLocalePreferences;
  }

  @override
  Future<void> saveUserLocalePreferences(String userLocalePreferences) async {
    await _localDataSorce.saveUserLocalePreferences(userLocalePreferences);
  }

  @override
  Future<void> deleteUserLocalePreferences() async {
    await _localDataSorce.deleteUserLocalePreferences();
  }
}
