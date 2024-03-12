import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story_app/features/story/data/model/all_story_data.dart';
import 'package:story_app/features/story/data/model/detail_story_data.dart';
import 'package:story_app/utils/env.dart';
import 'package:story_app/utils/exceptions.dart';

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

      final multiPartFile =
          http.MultipartFile.fromBytes('photo', imageBytes, filename: fileName);
      final Map<String, String> fields = {
        "description": description,
      };
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
        throw ServerExceptions();
      }
    } catch (_) {
      throw ServerExceptions();
    }
  }

  Future<AllStoryData> getAllStory({required String token}) async {
    try {
      final uri = Uri.parse('${Env.baseUrl}/stories');
      final response = await http.get(uri,
          headers: <String, String>{"Authorization": "Bearer $token"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AllStoryData.fromJson(jsonDecode(response.body));
      } else {
        throw ServerExceptions();
      }
    } catch (_) {
      throw ServerExceptions();
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
        throw ServerExceptions();
      }
    } catch (_) {
      throw ServerExceptions();
    }
  }
}