import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/firebase_config.dart';
import 'presentation/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/blocs/material/material_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'domain/usecases/get_all_materials.dart';
import 'data/repositories/material_repository_impl.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await FirebaseConfig.initialize();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const SmartFabApp());
}

class SmartFabApp extends StatelessWidget {
  const SmartFabApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authService: authService,
          )..add(const AuthCheckRequested()),
        ),
        BlocProvider(
          create: (context) => MaterialBloc(
            getAllMaterials: GetAllMaterials(
              MaterialRepositoryImpl(),
            ),
          )..add(const LoadMaterials()),
        ),
      ],
      child: MaterialApp(
        title: 'SmartFab Industries',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.factory,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'SmartFab Industries',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 