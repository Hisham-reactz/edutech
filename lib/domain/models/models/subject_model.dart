class SubjectModel {
  final int id;
  final String name;
  final int credits;
  final String teacher;

  SubjectModel({
    required this.id,
    required this.name,
    required this.credits,
    required this.teacher,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] as int,
      name: json['name'] as String,
      credits: json['credits'] as int,
      teacher: json['teacher'] as String,
    );
  }

  // Add any additional methods or properties as needed
}
