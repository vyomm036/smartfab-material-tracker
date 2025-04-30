import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/material/material_bloc.dart';
import '../../../domain/entities/material.dart';

class MaterialListScreen extends StatelessWidget {
  const MaterialListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materials'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add material screen
            },
          ),
        ],
      ),
      body: BlocBuilder<MaterialBloc, MaterialState>(
        builder: (context, state) {
          if (state is MaterialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MaterialError) {
            return Center(child: Text(state.message));
          } else if (state is MaterialLoaded) {
            return _buildMaterialList(state.materials);
          }
          return const Center(child: Text('No materials found'));
        },
      ),
    );
  }

  Widget _buildMaterialList(List<Material> materials) {
    return ListView.builder(
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final material = materials[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(material.name),
            subtitle: Text(
              '${material.quantity} ${material.unit} - \$${material.totalValue.toStringAsFixed(2)}',
            ),
            trailing: Text(material.category),
            onTap: () {
              // TODO: Navigate to material details screen
            },
          ),
        );
      },
    );
  }
} 