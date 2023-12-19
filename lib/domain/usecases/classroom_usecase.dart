import 'package:get_it/get_it.dart';

import '../../data/repositories/classroom_repository.dart';
import '../models/models/classroom_model.dart';

class ClassroomUseCase {
  final ClassroomRepository _repository =
      GetIt.instance.get<ClassroomRepository>();

  Future<List<ClassroomModel>> getClassrooms() async {
    try {
      return await _repository.getClassrooms();
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<ClassroomModel> getClassroomById(int classroomId) async {
    try {
      return await _repository.getClassroomById(classroomId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<void> assignSubjectToClassroom(int classroomId, int subjectId) async {
    try {
      return await _repository.assignSubjectToClassroom(classroomId, subjectId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<void> assignStudentToClassroom(int classroomId, int studentId) async {
    try {
      return await _repository.assignStudentToClassroom(classroomId, studentId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<void> removeStudentFromClassroom(
      int studentId, int classroomId) async {
    try {
      return await _repository.removeStudentFromClassroom(
          studentId, classroomId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }
}
