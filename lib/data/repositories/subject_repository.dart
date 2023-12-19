import 'dart:convert';
import 'package:edutech/domain/models/models/subject_model.dart';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';

class SubjectRepository {
  Future<List<SubjectModel>> getSubjects() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/subjects/?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['subjects'];
      return data.map((json) => SubjectModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  Future<SubjectModel> getSubjectById(int subjectId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/subjects/$subjectId?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SubjectModel.fromJson(data);
    } else {
      throw Exception('Failed to load subject details');
    }
  }
}
