import 'package:edutech/data/repositories/subject_repository.dart';
import 'package:edutech/domain/models/models/subject_model.dart';
import 'package:get_it/get_it.dart';

class SubjectUseCase {
  final SubjectRepository _repository = GetIt.instance.get<SubjectRepository>();

  Future<List<SubjectModel>> getSubjects() async {
    try {
      return await _repository.getSubjects();
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }

  Future<SubjectModel> getSubjectById(int subjectId) async {
    try {
      return await _repository.getSubjectById(subjectId);
    } catch (e) {
      // Handle errors or exceptions
      rethrow;
    }
  }
}
