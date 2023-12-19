class StudentModel {
  final int id;
  final String name;
  final int age;
  final String email;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
    );
  }

  // Add any additional methods or properties as needed
}
