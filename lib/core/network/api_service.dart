import 'dart:convert';

import 'package:todoapp/core/network/api_endpoints.dart';
import 'package:todoapp/model/get_posts_model.dart';
import 'package:http/http.dart';
import 'package:todoapp/model/todo_model.dart';

class ApiService {
  Future<List<GetPostsModel>> getPosts() async {
    final response = await get(Uri.parse(APIEndPoints.baseUrl+APIEndPoints.getPost));
    if (response.statusCode == 200) {
      // return GetPostsModel.fromJson(json.decode(response.body));
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => GetPostsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<GetTodosModel>> getTodos() async {
    final response = await get(Uri.parse(APIEndPoints.baseUrl+APIEndPoints.getTodos));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => GetTodosModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}