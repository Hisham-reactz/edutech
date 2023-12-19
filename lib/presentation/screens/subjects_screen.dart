import 'package:flutter/material.dart';

import '../../domain/models/models/subject_model.dart';
import '../../domain/usecases/subject_usecase.dart';

class SubjectsScreen extends StatefulWidget {
  final SubjectUseCase subjectUseCase;

  const SubjectsScreen(this.subjectUseCase, {super.key});

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
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
        title: const Text('Subjects'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _subjects.length,
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                return ListTile(
                  title: Text(subject.name),
                  subtitle: Text('Teacher: ${subject.teacher}'),
                  onTap: () {
                    _showSubjectDetails(subject);
                  },
                );
              },
            ),
    );
  }

  void _showSubjectDetails(SubjectModel subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectDetailsScreen(subject),
      ),
    );
  }
}

class SubjectDetailsScreen extends StatelessWidget {
  final SubjectModel subject;

  const SubjectDetailsScreen(this.subject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${subject.name}'),
            Text('Credits: ${subject.credits}'),
            Text('Teacher: ${subject.teacher}'),
          ],
        ),
      ),
    );
  }
}
