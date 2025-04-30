import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.operator;
  final List<String> _selectedOperations = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Mock operations list (in real app, fetch from database)
  final List<String> _availableOperations = [
    'Cutting',
    'Welding',
    'Assembly',
    'Painting',
    'Quality Control',
    'Packaging',
  ];

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      context.read<AuthBloc>().add(
        RegisterUserRequested(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          role: _selectedRole,
          assignedOperations: _selectedRole == UserRole.operator 
            ? _selectedOperations 
            : null,
        ),
      );
      
      // Reset form
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      setState(() {
        _selectedRole = UserRole.operator;
        _selectedOperations.clear();
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User registration request sent')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New User',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Registration Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Role Selection
                  DropdownButtonFormField<UserRole>(
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(),
                    ),
                    items: UserRole.values.map((role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(role.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                  ),
                  
                  // Show operations selection only for operators
                  if (_selectedRole == UserRole.operator) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Assigned Operations:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(_availableOperations.length, (index) {
                      final operation = _availableOperations[index];
                      return CheckboxListTile(
                        title: Text(operation),
                        value: _selectedOperations.contains(operation),
                        onChanged: (selected) {
                          setState(() {
                            if (selected == true) {
                              _selectedOperations.add(operation);
                            } else {
                              _selectedOperations.remove(operation);
                            }
                          });
                        },
                      );
                    }),
                  ],
                  
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _registerUser,
                      child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Register User'),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // User List (In a real app, you'd fetch this from Firestore)
            const Text(
              'Existing Users',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // This would be replaced with a StreamBuilder or FutureBuilder
            // to display actual users from Firestore
            const Center(
              child: Text('User list will be displayed here'),
            ),
          ],
        ),
      ),
    );
  }
} 