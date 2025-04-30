import 'package:flutter/material.dart';

class AssignedTasksScreen extends StatelessWidget {
  const AssignedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Tasks'),
      ),
      body: const Center(
        child: Text('Assigned tasks will be displayed here'),
      ),
    );
  }
} 