import 'package:flutter/material.dart';

class MaterialManagementScreen extends StatelessWidget {
  const MaterialManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Management'),
      ),
      body: const Center(
        child: Text('Material management features will be implemented here'),
      ),
    );
  }
} 