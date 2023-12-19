import 'package:flutter/material.dart';

import '../../domain/models/models/classroom_model.dart';
import '../../domain/usecases/classroom_usecase.dart';

class ClassroomsScreen extends StatefulWidget {
  final ClassroomUseCase classroomUseCase;

  const ClassroomsScreen(this.classroomUseCase, {super.key});

  @override
  _ClassroomsScreenState createState() => _ClassroomsScreenState();
}

class _ClassroomsScreenState extends State<ClassroomsScreen> {
  List<ClassroomModel> _classrooms = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadClassrooms();
  }

  Future<void> _loadClassrooms() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final classrooms = await widget.classroomUseCase.getClassrooms();

      setState(() {
        _classrooms = classrooms;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
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
        title: const Text('Classrooms'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _classrooms.length,
              itemBuilder: (context, index) {
                final classroom = _classrooms[index];
                return ListTile(
                  title: Text(classroom.name),
                  subtitle: Text(
                      'Layout: ${classroom.layout}, Size: ${classroom.size}'),
                  onTap: () {
                    _showClassroomDetails(classroom);
                  },
                );
              },
            ),
    );
  }

  void _showClassroomDetails(ClassroomModel classroom) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClassroomDetailsScreen(classroom),
      ),
    );
  }
}

class ClassroomDetailsScreen extends StatelessWidget {
  final ClassroomModel classroom;

  const ClassroomDetailsScreen(this.classroom, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${classroom.name}'),
            Text('Layout: ${classroom.layout}'),
            Text('Size: ${classroom.size}'),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/assign_subject',
                        arguments: classroom,
                      );
                    },
                    child: const Text('Assign subject'),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/assign_student',
                        arguments: classroom,
                      );
                    },
                    child: const Text('Assign Student'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
