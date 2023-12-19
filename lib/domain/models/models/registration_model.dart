class RegistrationModel {
  final int id;
  final int studentId;
  final int subjectId;

  RegistrationModel({
    required this.id,
    required this.studentId,
    required this.subjectId,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      id: json['id'] as int,
      studentId: json['student'] as int,
      subjectId: json['subject'] as int,
    );
  }

  // Add any additional methods or properties as needed
}
