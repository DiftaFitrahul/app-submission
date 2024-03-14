import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../network/exceptions.dart';
import '../../../../../utils/env.dart';
import '../model/login_data.dart';

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
    } on http.ClientException catch (err) {
      String msg = "";
      if (err.toString().contains(
          "ClientException with SocketException: Failed host lookup")) {
        msg = "No internet";
      } else {
        msg = "Connection error";
      }
      throw ClientExceptions(message: msg);
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        return body['message'];
      } else {
        final errMessage =
            jsonDecode(response.body)['message'] ?? "Error occured!!";
        throw DataExceptions(message: errMessage);
      }
    } on http.ClientException catch (err) {
      String msg = "";
      if (err.toString().contains(
          "ClientException with SocketException: Failed host lookup")) {
        msg = "No internet";
      } else {
        msg = "Connection error";
      }
      throw ClientExceptions(message: msg);
    } catch (err) {
      switch (err) {
        case DataExceptions():
          throw DataExceptions(message: err.message);
        default:
          throw const ServerExceptions(message: "Error occured!!");
      }
    }
  }
}
