import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterUserRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final List<String>? assignedOperations;

  const RegisterUserRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.assignedOperations,
  });

  @override
  List<Object?> get props => [name, email, password, role, assignedOperations];
}

class SignOutRequested extends AuthEvent {} 