import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildDashboardItem(context, 'View Students', '/students'),
          _buildDashboardItem(context, 'View Subjects', '/subjects'),
          _buildDashboardItem(context, 'View Classrooms', '/classrooms'),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4.0,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
