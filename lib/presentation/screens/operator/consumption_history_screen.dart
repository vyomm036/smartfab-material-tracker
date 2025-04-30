import 'package:flutter/material.dart';

class ConsumptionHistoryScreen extends StatelessWidget {
  const ConsumptionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumption History'),
      ),
      body: const Center(
        child: Text('Material consumption history will be displayed here'),
      ),
    );
  }
} 