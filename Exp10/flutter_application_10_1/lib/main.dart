import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // <-- You MUST import this
import 'formula_dashboard.dart'; // <-- Importing our new dashboard

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // You MUST pass the options, otherwise, it won't connect
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentLoginScreen(),
  ));
}

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? errorMsg;

  // ---
  // IMPORTANT: For this to work, you must MANUALLY create a collection
  // in your Firestore database called 'Students' (with a capital S).
  //
  // Inside 'Students', create a document and give it three fields (all strings):
  // 1. name: "Your Name"
  // 2. email: "test@example.com"
  // 3. password: "password123"
  // ---

  Future<void> _login() async {
    // ---
    // !! SECURITY WARNING !!
    // This method is for educational purposes only.
    // Storing plain-text passwords in a database is extremely insecure.
    // In a real app, always use Firebase Authentication (firebase_auth)
    // which securely hashes passwords and manages user sessions.
    // ---

    try {
      final snap = await FirebaseFirestore.instance
          .collection('Students') // <-- Changed to 'Students' collection
          .where('email', isEqualTo: _email.text.trim())
          .limit(1)
          .get();

      if (snap.docs.isEmpty) {
        // No user found with that email
        setState(() => errorMsg = "Invalid email or password");
        return;
      }

      // User email was found, now check the password
      final user = snap.docs.first.data();
      if (user['password'] == _password.text.trim()) {
        // Password MATCHES!
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            // Navigate to our new FormulaDashboardScreen
            builder: (_) => FormulaDashboardScreen(studentName: user['name']),
          ),
        );
      } else {
        // Password does NOT match
        setState(() => errorMsg = "Invalid email or password");
      }
    } catch (e) {
      // This will catch Firestore errors (e.g., missing index, permissions)
      setState(() => errorMsg = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Login'),
        backgroundColor: Colors.deepPurple, // Matching our theme
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using a thematic placeholder icon
            // Image.network(
            //   'https://placehold.co/150x150/673AB7/FFFFFF?text=MathsApp',
            //   height: 150,
            //   width: 150,
            // ),
            SizedBox(height: 20),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                  backgroundColor: Colors.deepPurple, // Matching our theme
                  foregroundColor: Colors.white),
              child: const Text('Login'),
            ),
            if (errorMsg != null) ...[
              const SizedBox(height: 10),
              Text(errorMsg!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}