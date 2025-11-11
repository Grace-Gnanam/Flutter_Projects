import 'package:flutter/material.dart';

class FormulaDashboardScreen extends StatelessWidget {
  final String studentName; // Changed from userName
  const FormulaDashboardScreen({super.key, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formula Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Matching our theme
        automaticallyImplyLeading: true, // Shows back button (if not replaced)
      ),
      body: Center(
        child: Text(
          "Welcome, $studentName!",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      // Optional: A light background that fits the theme
      backgroundColor: Colors.deepPurple[50],
    );
  }
}