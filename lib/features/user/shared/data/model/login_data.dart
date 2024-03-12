import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_data.freezed.dart';
part 'login_data.g.dart';

@freezed
class LoginData with _$LoginData {
  const factory LoginData({
    @Default(false) bool error,
    @Default("") String message,
    @Default(LoginResult()) LoginResult loginResult,
  }) = _LoginData;
  factory LoginData.fromJson(Map<String, Object?> json) =>
      _$LoginDataFromJson(json);
}

@freezed
class LoginResult with _$LoginResult {
  const factory LoginResult({
    @Default("") String userId,
    @Default("") String name,
    @Default("") String token,
  }) = _LoginResult;
  factory LoginResult.fromJson(Map<String, Object?> json) =>
      _$LoginResultFromJson(json);
}
