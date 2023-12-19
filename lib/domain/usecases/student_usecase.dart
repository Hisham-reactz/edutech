import 'package:get_it/get_it.dart';

import '../../data/repositories/student_repository.dart';
import '../models/models/student_model.dart';

class StudentUseCase {
  final StudentRepository _repository = GetIt.instance.get<StudentRepository>();

  Future<List<StudentModel>> getStudents() async {
    try {
      return await _repository.getStudents();
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<StudentModel> getStudentById(int studentId) async {
    try {
      return await _repository.getStudentById(studentId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }
}
