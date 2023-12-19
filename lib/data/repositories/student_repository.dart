import 'dart:convert';
import 'package:edutech/domain/models/models/student_model.dart';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';

class StudentRepository {
  Future<List<StudentModel>> getStudents() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/students/?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['students'];
      return data.map((json) => StudentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<StudentModel> getStudentById(int studentId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/students/$studentId?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return StudentModel.fromJson(data);
    } else {
      throw Exception('Failed to load student details');
    }
  }
}
