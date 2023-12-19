import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'config/app_config.dart';
import 'data/repositories/classroom_repository.dart';
import 'data/repositories/student_repository.dart';
import 'data/repositories/subject_repository.dart';
import 'domain/usecases/classroom_usecase.dart';
import 'domain/usecases/student_usecase.dart';
import 'domain/usecases/subject_usecase.dart';
import 'presentation/screens/assign_student_screen.dart';
import 'presentation/screens/assign_subject_screen.dart';
import 'presentation/screens/classrooms_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/students_screen.dart';
import 'presentation/screens/subjects_screen.dart';

void main() {
  final getIt = GetIt.instance;

  // Register repositories
  getIt.registerLazySingleton<StudentRepository>(() => StudentRepository());
  getIt.registerLazySingleton<SubjectRepository>(() => SubjectRepository());
  getIt.registerLazySingleton<ClassroomRepository>(() => ClassroomRepository());

  // Register use cases
  getIt.registerLazySingleton<StudentUseCase>(() => StudentUseCase());
  getIt.registerLazySingleton<SubjectUseCase>(() => SubjectUseCase());
  getIt.registerLazySingleton<ClassroomUseCase>(() => ClassroomUseCase());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/students': (context) => StudentsScreen(StudentUseCase()),
        '/subjects': (context) => SubjectsScreen(SubjectUseCase()),
        '/classrooms': (context) => ClassroomsScreen(ClassroomUseCase()),
        '/assign_subject': (context) => AssignSubjectScreen(
              ClassroomUseCase(),
              SubjectUseCase(),
            ),
        '/assign_student': (context) => AssignStudentScreen(
              ClassroomUseCase(),
              StudentUseCase(),
            ),
      },
    );
  }
}
