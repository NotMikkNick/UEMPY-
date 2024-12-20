import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // This file is generated when setting up Firebase for your project
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Constructor updated to include the 'key' parameter
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: const MyHomePage(),  // MyHomePage now has a const constructor
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Constructor updated to include the 'key' parameter
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Test')),
      body: const Center(child: Text('Firebase is ready!')),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign in with email and password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      // Attempt sign-in with the provided credentials
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;  // Return the signed-in user
    } catch (e) {
      // Log errors, but do not use 'print' in production code
      // Replace with a proper logging method if needed
      debugPrint("Error: $e");
      return null;
    }
  }

  // Method to sign out the user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}