# EduTech

## Description

Student App.

## Features

  - Display the list of students and get details for an individual student.
  - Display the list of subjects and get details for an individual subject.
  - Display the list of classrooms and get details for an individual classroom.
  - Assign a subject to a classroom (also make a provision to change assignment)
  - Assign a student to a classroom. 
  - Remove a student from a classroom if she's assigned to it.

## Folder Structure

/project_root
|-- /lib
| |-- /config
| | |-- app_config.dart
| | |-- api_config.dart
| |-- /utils
| | |-- validator.dart
| | |-- api_error_handler.dart
| |-- /screens
| | |-- home_screen.dart
| | |-- assign_student_screen.dart
| | |-- assign_subject_screen.dart
| | |-- classrooms_screen.dart
| | |-- subjects_screen.dart
| | |-- students_screen.dart
| |-- /domain
| | |-- models
| | | |-- classroom_model.dart
| | | |-- registration_model.dart
| | | |-- student_model.dart
| | | |-- subject_model.dart
| | |-- repositories
| | | |-- classroom_repository.dart
| | | |-- registration_repository.dart
| | | |-- student_repository.dart
| | | |-- subject_repository.dart
| | |-- usecases
| | | |-- classroom_usecase.dart
| | | |-- registration_usecase.dart
| | | |-- student_usecase.dart
| | | |-- subject_usecase.dart
|-- /test
|-- /unit
|-- #



## Getting Started


# Clone the repository
git clone https://github.com/your-username/your-project.git

# Navigate to the project directory
cd your-project

# Install dependencies
flutter pub get

# Run the app
flutter run
Dependencies
List any external packages or dependencies your project uses.

Contribution Guidelines
Explain how others can contribute to your project. Include information about code style, submitting issues, and pull requests.

License
This project is licensed under the [Your License Name] - see the LICENSE.md file for details.