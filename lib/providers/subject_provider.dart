import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/subject.dart';

class SubjectsProvider with ChangeNotifier {
  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  Future<void> fetchSubjects() async {
    const url = 'https://trogon.info/interview/php/api/subjects.php';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _subjects = data.map((json) => Subject.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load subjects');
      }
    } catch (error) {
      rethrow;
    }
  }
}
