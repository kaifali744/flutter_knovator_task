import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/models/post_model.dart';

class ApiClient {
  final String base = 'https://jsonplaceholder.typicode.com';

  Future<List<PostModel>> fetchPosts() async {
    final url = Uri.parse('$base/posts');
    final resp = await http.get(url).timeout(const Duration(seconds: 15));
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body) as List;
      return data.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch posts. Status: ${resp.statusCode}');
    }
  }

  Future<PostModel> fetchPostById(int id) async {
    final url = Uri.parse('$base/posts/$id');
    final resp = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "User-Agent": "Mozilla/5.0 (Mobile; Flutter App)", // important
      },
    ).timeout(const Duration(seconds: 15));

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      return PostModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch post. Status: ${resp.statusCode}');
    }
  }
}
