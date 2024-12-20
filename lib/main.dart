import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // Falls du DefaultFirebaseOptions nutzt
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("Registrierung erfolgreich!");
    } catch (e) {
      print("Fehler bei der Registrierung: $e");
    }
  }

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("Login erfolgreich!");
    } catch (e) {
      print("Fehler beim Login: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("Logout erfolgreich!");
    } catch (e) {
      print("Fehler beim Logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase E-Mail/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-Mail'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Passwort'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: const Text("Registrieren"),
            ),
            ElevatedButton(
              onPressed: signIn,
              child: const Text("Anmelden"),
            ),
            ElevatedButton(
              onPressed: signOut,
              child: const Text("Abmelden"),
            ),
          ],
        ),
      ),
    );
  }
}}