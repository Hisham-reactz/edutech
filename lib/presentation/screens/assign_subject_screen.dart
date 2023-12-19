import 'package:flutter/material.dart';

import '../../domain/models/models/classroom_model.dart';
import '../../domain/models/models/subject_model.dart';
import '../../domain/usecases/classroom_usecase.dart';
import '../../domain/usecases/subject_usecase.dart';

class AssignSubjectScreen extends StatefulWidget {
  final ClassroomUseCase classroomUseCase;
  final SubjectUseCase subjectUseCase;

  const AssignSubjectScreen(this.classroomUseCase, this.subjectUseCase,
      {super.key});

  @override
  _AssignSubjectScreenState createState() => _AssignSubjectScreenState();
}

class _AssignSubjectScreenState extends State<AssignSubjectScreen> {
  ClassroomModel? _selectedClassroom;
  SubjectModel? _selectedSubject;
  List<SubjectModel> _subjects = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final subjects = await widget.subjectUseCase.getSubjects();

      setState(() {
        _subjects = subjects;
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
        title: const Text('Assign Subject'),
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
                  DropdownButtonFormField<SubjectModel>(
                    value: _selectedSubject,
                    items: _subjects.map((subject) {
                      return DropdownMenuItem<SubjectModel>(
                        value: subject,
                        child: Text(subject.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSubject = value;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Select Subject'),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      _assignSubjectToClassroom();
                    },
                    child: const Text('Assign Subject'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _assignSubjectToClassroom() async {
    if (_selectedClassroom != null && _selectedSubject != null) {
      try {
        // Call use case to assign subject to classroom
        await widget.classroomUseCase.assignSubjectToClassroom(
          _selectedClassroom!.id,
          _selectedSubject!.id,
        );

        // Show success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subject assigned to classroom successfully'),
          ),
        );
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to assign subject to classroom'),
          ),
        );
      }
    } else {
      // Handle case where either classroom or subject is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both classroom and subject'),
        ),
      );
    }
  }
}
