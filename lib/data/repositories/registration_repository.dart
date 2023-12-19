import 'dart:convert';
import 'package:edutech/config/api_config.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/models/registration_model.dart';

class RegistrationRepository {
  Future<List<RegistrationModel>> getRegistrations() async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/registration/?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['registrations'];
      return data.map((json) => RegistrationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load registrations');
    }
  }

  Future<RegistrationModel> getRegistrationById(int registrationId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/registration/$registrationId?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RegistrationModel.fromJson(data);
    } else {
      throw Exception('Failed to load registration details');
    }
  }

  Future<RegistrationModel> createRegistration(
      int studentId, int subjectId) async {
    final response = await http.post(
      Uri.parse(
          '${ApiConfig.baseUrl}/registration/?api_key=${ApiConfig.apiKey}'),
      body: {'student': studentId, 'subject': subjectId},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body)['registration'];
      return RegistrationModel.fromJson(data);
    } else {
      throw Exception('Failed to create registration');
    }
  }

  Future<void> deleteRegistration(int registrationId) async {
    final response = await http.delete(
      Uri.parse(
          '${ApiConfig.baseUrl}/registration/$registrationId?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete registration');
    }
  }
}
