import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; // <-- You MUST import this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // You MUST pass the options, otherwise, it won't connect
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UpdateFormulaScreen(), // Changed to our new screen
  ));
}

class UpdateFormulaScreen extends StatefulWidget {
  const UpdateFormulaScreen({super.key});

  @override
  State<UpdateFormulaScreen> createState() => _UpdateFormulaScreenState();
}

class _UpdateFormulaScreenState extends State<UpdateFormulaScreen> {
  // Controllers for our formula fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _formulaController = TextEditingController();

  String _statusMessage = "Enter a formula name to search";
  String? _docId; // This will store the ID of the document we find

  // Get a reference to the 'Formulae' collection (Case-Sensitive!)
  final CollectionReference formulae =
      FirebaseFirestore.instance.collection("Formulae");

  /// Searches the 'Formulae' collection for a document with a matching 'name'
  Future<void> _searchFormula() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _statusMessage = "Please enter a formula name.";
        _docId = null;
      });
      return;
    }

    try {
      // Remember, this query is case-sensitive and needs the index we built
      final querySnapshot = await formulae.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isEmpty) {
        // No formula found with that exact name
        setState(() {
          _statusMessage = "Formula not found.";
          _docId = null;
          _categoryController.clear();
          _formulaController.clear();
        });
      } else {
        // Formula was found
        final formulaData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        final docId = querySnapshot.docs.first.id;

        // Populate the text fields with the data from Firestore
        setState(() {
          _docId = docId; // Save the document ID for the update
          _categoryController.text = formulaData['category'] ?? '';
          _formulaController.text = formulaData['formula'] ?? '';
          _statusMessage = "Formula loaded. You can now edit and update.";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "An error occurred: $e";
      });
    }
  }

  /// Updates the currently loaded formula document in Firestore
  Future<void> _updateFormula() async {
    if (_docId == null) {
      setState(() {
        _statusMessage = "Please search for a formula first.";
      });
      return;
    }

    final newCategory = _categoryController.text.trim();
    final newFormula = _formulaController.text.trim();

    if (newCategory.isEmpty || newFormula.isEmpty) {
      setState(() {
        _statusMessage = "Please fill in both Category and Formula.";
      });
      return;
    }

    try {
      // Use the saved _docId to update the specific document
      await formulae.doc(_docId).update({
        'category': newCategory,
        'formula': newFormula,
        // You could also update the 'name' if you add a 'name' controller
      });

      setState(() {
        _statusMessage = "Formula updated successfully!";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "Failed to update: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Formula Details"),
        backgroundColor: Colors.deepPurple, // Back to our purple theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- Search Section ---
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Enter formula name to search",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _searchFormula,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text("Search"),
              ),
              const Divider(height: 30, thickness: 1),

              // --- Edit Section ---
              TextField(
                controller: _categoryController, // Changed from _quantityController
                decoration: const InputDecoration(
                  labelText: "Category", // Changed from "Quantity"
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text, // Not a number anymore
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _formulaController, // Changed from _priceController
                decoration: const InputDecoration(
                  labelText: "Formula", // Changed from "Price (₹)"
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text, // Not a number anymore
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _updateFormula, // Calls our new update function
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Green for "Update"
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50)),
                child: const Text("Update"),
              ),
              const SizedBox(height: 20),

              // --- Status Message ---
              Text(
                _statusMessage,
                style: TextStyle(
                    color: _statusMessage.contains("not") ||
                            _statusMessage.contains("Please") ||
                            _statusMessage.contains("error")
                        ? Colors.red
                        : Colors.green,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}