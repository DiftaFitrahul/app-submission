import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../utils/env.dart';
import '../../../../network/exceptions.dart';
import '../model/all_story_data.dart';
import '../model/detail_story_data.dart';

class StoryDataSource {
  const StoryDataSource();

  Future<bool> addStory(
      {required String token,
      required String description,
      required String fileName,
      required List<int> imageBytes,
      double? lat,
      double? lon}) async {
    try {
      final uri = Uri.parse('${Env.baseUrl}/stories');
      final request = http.MultipartRequest('POST', uri);
      Map<String, String> fields = {};

      final multiPartFile =
          http.MultipartFile.fromBytes('photo', imageBytes, filename: fileName);
      if (lat != null && lon != null) {
        fields = {
          "description": description,
          "lat": "$lat",
          "lon": "$lon",
        };
      } else {
        fields = {
          "description": description,
        };
      }
      final Map<String, String> headers = {
        "Content-type": 'multipart/form-data',
        "Authorization": "Bearer $token"
      };
      request.files.add(multiPartFile);

      request.fields.addAll(fields);
      request.headers.addAll(headers);
      final response = await request.send();
      final statusCode = response.statusCode;
      final responseBody = await response.stream.bytesToString();

      if (statusCode == 200 || statusCode == 201) {
        return jsonDecode(responseBody)['error'];
      } else {
        throw const ServerExceptions();
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
    } catch (_) {
      throw const ServerExceptions();
    }
  }

  Future<AllStoryData> getStory(
      {required String token, required int page, required int size}) async {
    try {
      final uri = Uri.parse('${Env.baseUrl}/stories?page=$page&size=$size');
      final response = await http.get(uri,
          headers: <String, String>{"Authorization": "Bearer $token"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AllStoryData.fromJson(jsonDecode(response.body));
      } else {
        throw const ServerExceptions();
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
      throw ServerExceptions(message: err.toString());
    }
  }

  Future<DetailStoryData> getDetailStory(
      {required String token, required String id}) async {
    try {
      final uri = Uri.parse("${Env.baseUrl}/stories/$id");
      final response = await http.get(uri,
          headers: <String, String>{"Authorization": "Bearer $token"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return DetailStoryData.fromJson(jsonDecode(response.body));
      } else {
        throw const ServerExceptions();
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
      throw const ServerExceptions();
    }
  }
}
