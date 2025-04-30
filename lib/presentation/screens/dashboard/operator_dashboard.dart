import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../scanner/qr_scanner_screen.dart';
import '../operator/assigned_tasks_screen.dart';
import '../operator/consumption_history_screen.dart';

class OperatorDashboard extends StatelessWidget {
  const OperatorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operator Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildDashboardCard(
            context,
            'Scan Materials',
            Icons.qr_code_scanner,
            Colors.blue,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const QRScannerScreen(),
              ),
            ),
          ),
          _buildDashboardCard(
            context,
            'Assigned Tasks',
            Icons.assignment,
            Colors.green,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AssignedTasksScreen(),
              ),
            ),
          ),
          _buildDashboardCard(
            context,
            'Consumption History',
            Icons.history,
            Colors.orange,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ConsumptionHistoryScreen(),
              ),
            ),
          ),
          _buildDashboardCard(
            context,
            'Profile',
            Icons.person,
            Colors.purple,
            () {
              // Navigate to profile screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 