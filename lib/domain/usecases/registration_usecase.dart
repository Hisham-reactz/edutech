import 'package:edutech/domain/models/models/registration_model.dart';

import '../../data/repositories/registration_repository.dart';

class RegistrationUseCase {
  final RegistrationRepository _repository;

  RegistrationUseCase(this._repository);

  Future<List<RegistrationModel>> getRegistrations() async {
    try {
      return await _repository.getRegistrations();
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<RegistrationModel> getRegistrationById(int registrationId) async {
    try {
      return await _repository.getRegistrationById(registrationId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<RegistrationModel> createRegistration(
      int studentId, int subjectId) async {
    try {
      return await _repository.createRegistration(studentId, subjectId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<void> deleteRegistration(int registrationId) async {
    try {
      return await _repository.deleteRegistration(registrationId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }
}
