import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/user_model.dart';
import 'package:hive/hive.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box _userBox = Hive.box('users');

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user != null) {
        // Update last login time
        await _firestore.collection('users').doc(userCredential.user!.uid).update({
          'lastLogin': DateTime.now().toIso8601String(),
        });
        
        // Get user data from Firestore
        final userData = await _getUserData(userCredential.user!.uid);
        
        // Save to local storage
        await _userBox.put('currentUser', userData.toJson());
        
        return userData;
      }
      return null;
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

  // Register with email and password (Admin only functionality)
  Future<UserModel?> registerUser({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    List<String>? assignedOperations,
  }) async {
    try {
      // Check if current user is admin
      final currentUserData = await _getCurrentUserData();
      if (currentUserData?.role != UserRole.admin) {
        throw Exception('Only admins can register new users');
      }
      
      // Create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user != null) {
        final newUser = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          role: role,
          assignedOperations: assignedOperations ?? [],
          createdAt: DateTime.now(),
        );
        
        // Save to Firestore
        await _firestore.collection('users').doc(newUser.id).set(newUser.toJson());
        
        return newUser;
      }
      return null;
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _userBox.delete('currentUser');
    await _auth.signOut();
  }

  // Get user data from Firestore
  Future<UserModel> _getUserData(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    } else {
      throw Exception('User not found');
    }
  }

  // Get current user data
  Future<UserModel?> _getCurrentUserData() async {
    final user = currentUser;
    if (user != null) {
      try {
        return await _getUserData(user.uid);
      } catch (e) {
        print('Error getting current user data: $e');
        return null;
      }
    }
    return null;
  }

  // Check if user is admin
  Future<bool> isUserAdmin() async {
    final userData = await _getCurrentUserData();
    return userData?.role == UserRole.admin;
  }
} 