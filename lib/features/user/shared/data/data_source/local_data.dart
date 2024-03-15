import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataSource {
  const LocalDataSource();
  final _userIdKey = "userIdKey";
  final _tokenKey = "userTokenKey";
  final _userLocalePreferences = "userLocale";
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<String?> get userToken async =>
      await _secureStorage.read(key: _tokenKey, aOptions: _getAndroidOptions());

  Future<String?> get userId async => await _secureStorage.read(
      key: _userIdKey, aOptions: _getAndroidOptions());

  Future<String?> get userLocalePreferences async => await _secureStorage.read(
      key: _userLocalePreferences, aOptions: _getAndroidOptions());

  Future<void> saveDataUser(
      {required String userId, required String token}) async {
    await _secureStorage.write(
        key: _userIdKey, value: userId, aOptions: _getAndroidOptions());

    await _secureStorage.write(
        key: _tokenKey, value: token, aOptions: _getAndroidOptions());
  }

  Future<void> deleteDataUser() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }

  Future<void> saveUserLocalePreferences(String userLocalePreferences) async {
    await _secureStorage.write(
        key: _userLocalePreferences,
        value: userLocalePreferences,
        aOptions: _getAndroidOptions());
  }

  Future<void> deleteUserLocalePreferences() async {
    await _secureStorage.delete(
        key: _userLocalePreferences, aOptions: _getAndroidOptions());
  }
}
