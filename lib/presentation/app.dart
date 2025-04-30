import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'screens/auth/login_screen.dart';
import 'screens/dashboard/admin_dashboard.dart';
import 'screens/dashboard/operator_dashboard.dart';
import '../data/models/user_model.dart';
import '../services/auth_service.dart';

class SmartFabApp extends StatelessWidget {
  const SmartFabApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authService: AuthService(),
          )..add(AuthCheckRequested()),
        ),
        // Add other BlocProviders here as needed
      ],
      child: MaterialApp(
        title: 'SmartFab Material Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              // Navigate based on user role
              if (state.user.role == UserRole.admin) {
                return const AdminDashboard();
              } else {
                return const OperatorDashboard();
              }
            }
            // Show login screen if not authenticated or in other states
            return const LoginScreen();
          },
        ),
      ),
    );
  }
} 