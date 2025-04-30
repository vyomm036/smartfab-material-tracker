import 'package:flutter/material.dart';
import '../../../domain/entities/material.dart';

class MaterialDetailsScreen extends StatelessWidget {
  final Material material;

  const MaterialDetailsScreen({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(material.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit material screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              'Basic Information',
              [
                _buildInfoRow('Name', material.name),
                _buildInfoRow('Description', material.description),
                _buildInfoRow('Category', material.category),
                _buildInfoRow('Unit', material.unit),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Quantity & Pricing',
              [
                _buildInfoRow('Quantity', '${material.quantity} ${material.unit}'),
                _buildInfoRow('Unit Price', '\$${material.unitPrice.toStringAsFixed(2)}'),
                _buildInfoRow('Total Value', '\$${material.totalValue.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Additional Information',
              [
                if (material.supplier != null)
                  _buildInfoRow('Supplier', material.supplier!),
                if (material.location != null)
                  _buildInfoRow('Location', material.location!),
                _buildInfoRow('Last Updated', material.lastUpdated.toString()),
                _buildInfoRow('Status', material.isActive ? 'Active' : 'Inactive'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
} 