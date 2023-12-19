import 'package:flutter/material.dart';

import '../../domain/models/models/student_model.dart';
import '../../domain/usecases/student_usecase.dart';

class StudentsScreen extends StatefulWidget {
  final StudentUseCase studentUseCase;

  const StudentsScreen(this.studentUseCase, {super.key});

  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<StudentModel> _students = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final students = await widget.studentUseCase.getStudents();

      setState(() {
        _students = students;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text('Age: ${student.age}'),
                  onTap: () {
                    _showStudentDetails(student);
                  },
                );
              },
            ),
    );
  }

  void _showStudentDetails(StudentModel student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsScreen(student),
      ),
    );
  }
}

class StudentDetailsScreen extends StatelessWidget {
  final StudentModel student;

  const StudentDetailsScreen(this.student, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${student.name}'),
            Text('Age: ${student.age}'),
            Text('Email: ${student.email}'),
          ],
        ),
      ),
    );
  }
}
