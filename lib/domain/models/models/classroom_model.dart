class ClassroomModel {
  final int id;
  final String name;
  final String layout;
  final int size;

  ClassroomModel({
    required this.id,
    required this.name,
    required this.layout,
    required this.size,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> json) {
    return ClassroomModel(
      id: json['id'] as int,
      name: json['name'] as String,
      layout: json['layout'] as String,
      size: json['size'] as int,
    );
  }

  // Add any additional methods or properties as needed
}
