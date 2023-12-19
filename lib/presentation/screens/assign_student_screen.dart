import 'package:flutter/material.dart';

import '../../domain/models/models/classroom_model.dart';
import '../../domain/models/models/student_model.dart';
import '../../domain/usecases/classroom_usecase.dart';
import '../../domain/usecases/student_usecase.dart';

class AssignStudentScreen extends StatefulWidget {
  final ClassroomUseCase classroomUseCase;
  final StudentUseCase studentUseCase;

  const AssignStudentScreen(this.classroomUseCase, this.studentUseCase,
      {super.key});

  @override
  _AssignStudentScreenState createState() => _AssignStudentScreenState();
}

class _AssignStudentScreenState extends State<AssignStudentScreen> {
  ClassroomModel? _selectedClassroom;
  StudentModel? _selectedStudent;
  List<StudentModel> _students = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadClassrooms();
    _loadStudents();
  }

  Future<void> _loadClassrooms() async {
    try {
      setState(() {
        _isLoading = true;
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
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
      setClassRoom();
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  setClassRoom() {
    setState(() {
      _selectedClassroom =
          ModalRoute.of(context)?.settings.arguments as ClassroomModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Student to Classroom'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Class Room - ${_selectedClassroom?.name}'),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<StudentModel>(
                    value: _selectedStudent,
                    items: _students.map((student) {
                      return DropdownMenuItem<StudentModel>(
                        value: student,
                        child: Text(student.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedStudent = value;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Select Student'),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      _assignStudentToClassroom();
                    },
                    child: const Text('Assign Student'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _removeStudentFromClassroom();
                    },
                    child: const Text('Remove Student'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _assignStudentToClassroom() async {
    if (_selectedClassroom != null && _selectedStudent != null) {
      // Check if the classroom has a subject assigned

      try {
        // Call use case to assign student to classroom
        await widget.classroomUseCase.assignStudentToClassroom(
          _selectedClassroom!.id,
          _selectedStudent!.id,
        );

        // Show success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Student assigned to classroom successfully'),
          ),
        );
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to assign student to classroom'),
          ),
        );
      }
    } else {
      // Handle case where the classroom doesn't have a subject assigned
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Cannot assign student. Classroom has no subject assigned.'),
        ),
      );
    }
  }

  Future<void> _removeStudentFromClassroom() async {
    if (_selectedClassroom != null && _selectedStudent != null) {
      try {
        // Call use case to remove student from classroom
        await widget.classroomUseCase.removeStudentFromClassroom(
          _selectedStudent!.id,
          _selectedClassroom!.id,
        );

        // Show success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Student removed from classroom successfully'),
          ),
        );
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to remove student from classroom'),
          ),
        );
      }
    } else {
      // Handle case where either classroom or student is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both classroom and student'),
        ),
      );
    }
  }
}
