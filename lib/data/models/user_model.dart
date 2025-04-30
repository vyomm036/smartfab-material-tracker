import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
enum UserRole {
  @HiveField(0)
  admin,
  @HiveField(1)
  manager,
  @HiveField(2)
  operator,
  @HiveField(3)
  viewer
}

@HiveType(typeId: 1)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String email;
  
  @HiveField(3)
  final UserRole role;
  
  @HiveField(4)
  final List<String> assignedOperations;
  
  @HiveField(5)
  final DateTime createdAt;
  
  @HiveField(6)
  final DateTime? lastLogin;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.assignedOperations = const [],
    required this.createdAt,
    this.lastLogin,
  });

  UserModel copyWith({
    String? name,
    UserRole? role,
    List<String>? assignedOperations,
    DateTime? lastLogin,
  }) {
    return UserModel(
      id: this.id,
      name: name ?? this.name,
      email: this.email,
      role: role ?? this.role,
      assignedOperations: assignedOperations ?? this.assignedOperations,
      createdAt: this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'assignedOperations': assignedOperations,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
      ),
      assignedOperations: List<String>.from(json['assignedOperations'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] != null 
        ? DateTime.parse(json['lastLogin'] as String) 
        : null,
    );
  }

  @override
  List<Object?> get props => [
    id, name, email, role, assignedOperations, createdAt, lastLogin
  ];
} 