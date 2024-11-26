import 'dart:convert';

import 'package:elms/models/moodule.dart';
import 'package:elms/models/video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModulesProvider with ChangeNotifier {
  List<Module> _modules = [];

  List<Module> get modules => [..._modules];

  Future<void> fetchModules(int subjectId) async {
    final url =
        'https://trogon.info/interview/php/api/modules.php?subject_id=$subjectId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        _modules = data.map((module) => Module.fromJson(module)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load modules');
      }
    } catch (error) {
      rethrow;
    }
  }

  List<Video> _videos = [];

  List<Video> get videos => [..._videos];

  Future<void> fetchVideos(int moduleId) async {
    final url =
        'https://trogon.info/interview/php/api/videos.php?module_id=$moduleId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        _videos = data.map((video) => Video.fromJson(video)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (error) {
      rethrow;
    }
  }
}
