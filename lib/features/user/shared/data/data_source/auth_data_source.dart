import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:story_app/features/user/shared/data/model/login_data.dart';
import 'package:story_app/utils/env.dart';
import 'package:story_app/network/exceptions.dart';

class AuthDataSource {
  const AuthDataSource();
  Future<LoginData> login(
      {required String email, required String password}) async {
    try {
      final uri = Uri.parse('${Env.baseUrl}/login');
      final response = await http.post(uri, body: <String, String>{
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginData.fromJson(jsonDecode(response.body));
      } else {
        final errMessage =
            jsonDecode(response.body)['message'] ?? "Error occured!!";
        throw DataExceptions(message: errMessage);
      }
    } catch (err) {
      switch (err) {
        case DataExceptions():
          throw DataExceptions(message: err.message);
        default:
          throw const ServerExceptions(message: "Error occured!!");
      }
    }
  }

  Future<String> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final uri = Uri.parse('${Env.baseUrl}/register');
      final response = await http.post(uri, body: <String, String>{
        "name": name,
        "email": email,
        "password": password,
      });
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        return body['message'];
      } else {
        log("ini dijalankan 4");
        final errMessage =
            jsonDecode(response.body)['message'] ?? "Error occured!!";
        throw DataExceptions(message: errMessage);
      }
    } catch (err) {
      log("ini dijankan 1");
      switch (err) {
        case DataExceptions():
          throw DataExceptions(message: err.message);
        default:
          log(err.toString());
          throw const ServerExceptions(message: "Error occured!!");
      }
    }
  }
}
