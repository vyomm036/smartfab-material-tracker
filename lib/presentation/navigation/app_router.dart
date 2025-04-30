import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/material/material_list_screen.dart';
import '../screens/material/material_form_screen.dart';
import '../screens/material/material_details_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../blocs/auth/auth_bloc.dart';
import '../../domain/entities/material.dart' as material_entity;

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is! Authenticated && settings.name != '/auth/login' && settings.name != '/auth/register') {
              return const LoginScreen();
            }

            switch (settings.name) {
              case '/':
                return const MaterialListScreen();
              case '/auth/login':
                return const LoginScreen();
              case '/auth/register':
                return const RegisterScreen();
              case '/materials/add':
                return const MaterialFormScreen();
              case '/materials/edit':
                final material = settings.arguments as material_entity.Material;
                return MaterialFormScreen(material: material);
              case '/materials/details':
                final material = settings.arguments as material_entity.Material;
                return MaterialDetailsScreen(material: material);
              default:
                return Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                );
            }
          },
        );
      },
    );
  }
} 