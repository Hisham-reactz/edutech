import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:edutech/config/api_config.dart';

import '../../domain/models/models/classroom_model.dart';

class ClassroomRepository {
  Future<List<ClassroomModel>> getClassrooms() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/classrooms/?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['classrooms'];
      return data.map((json) => ClassroomModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load classrooms');
    }
  }

  Future<ClassroomModel> getClassroomById(int classroomId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/classrooms/$classroomId?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ClassroomModel.fromJson(data);
    } else {
      throw Exception('Failed to load classroom details');
    }
  }

  Future<void> assignSubjectToClassroom(int classroomId, int subjectId) async {
    final response = await http.patch(
      Uri.parse(
          '${ApiConfig.baseUrl}/classrooms/$classroomId?api_key=${ApiConfig.apiKey}'),
      body: {'subject': subjectId.toString()},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to assign subject to classroom');
    }
  }

  Future<void> assignStudentToClassroom(int classroomId, int studentId) async {
    final response = await http.post(
      Uri.parse(
          '${ApiConfig.baseUrl}/registration/?api_key=${ApiConfig.apiKey}'),
      body: {
        'student': studentId.toString(),
        'subject': classroomId.toString()
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to assign student to classroom');
    }
  }

  Future<void> removeStudentFromClassroom(
      int studentId, int classroomId) async {
    final response = await http.delete(
      Uri.parse(
          '${ApiConfig.baseUrl}/registration/$studentId?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove student from classroom');
    }
  }
}
