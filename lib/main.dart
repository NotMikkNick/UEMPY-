import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // This file is generated when setting up Firebase for your project
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _signUp() async {
    final user = await _authService.signUpWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      debugPrint('User signed up: ${user.email}');
    }
  }

  void _signIn() async {
    final user = await _authService.signInWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      debugPrint('User signed in: ${user.email}');
    }
  }

  void _signOut() async {
    await _authService.signOut();
    debugPrint('User signed out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Auth Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
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
      debugPrint("Error: $e");
      return null;
    }
  }

  // Method to sign up with email and password
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      // Attempt to sign up with the provided credentials
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;  // Return the newly created user
    } catch (e) {
      // Log errors, but do not use 'print' in production code
      debugPrint("Error: $e");
      return null;
    }
  }

  // Method to sign out the user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}