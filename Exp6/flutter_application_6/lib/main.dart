// main.dart

import 'package:flutter/material.dart';
import 'databasehelper.dart';
// import 'package:sqflite/sqflite.dart';
import 'formula.dart'; // <-- CHANGED: Import formula.dart

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  // <-- CHANGED: Controllers renamed for clarity
  final _nameController = TextEditingController();
  final _formulaController = TextEditingController();
  final _categoryController = TextEditingController();

  List<Formula> _formulas = []; // <-- CHANGED: List of Formula objects

  @override
  void initState() {
    super.initState();
    _showAllFormulas(); // <-- CHANGED: Method name
  }

  // <-- CHANGED: Method to read formulas
  Future<void> _showAllFormulas() async {
    final formulas = await DatabaseHelper.instance.readAllFormulas();
    setState(() {
      _formulas = formulas;
    });
  }

  // <-- REMOVED: getTotalStockValue() is no longer needed

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Math Formula Reference", // <-- CHANGED
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 235, 240), // <-- Changed bg color
        appBar: AppBar(
          title: const Text("Math Formula Reference"), // <-- CHANGED
          backgroundColor: Colors.blueGrey[800], // <-- Changed bar color
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // <-- CHANGED: First text field (Name)
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "Enter formula name (e.g., Pythagorean Theorem)",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the formula name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // <-- CHANGED: Second text field (Formula)
                TextFormField(
                  controller: _formulaController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "Enter formula (e.g., a^2 + b^2 = c^2)",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the formula";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // <-- CHANGED: Third text field (Category)
                TextFormField(
                  controller: _categoryController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "Enter category (e.g., Geometry)",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the category";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[600], // <-- Changed button color
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // <-- CHANGED: Logic to create and save a Formula
                          String name = _nameController.text;
                          String formulaText = _formulaController.text;
                          String category = _categoryController.text;

                          Formula formula = Formula(
                              name: name,
                              formula: formulaText,
                              category: category);
                              
                          await DatabaseHelper.instance.insertFormula(formula);
                          await _showAllFormulas();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Formula Details Saved")), // <-- CHANGED
                          );

                          _nameController.clear();
                          _formulaController.clear();
                          _categoryController.clear();
                        }
                      },
                      child: const Text("Add Formula"), // <-- CHANGED
                    );
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  // <-- CHANGED: ListView builder for formulas
                  child: _formulas.isEmpty
                      ? const Center(child: Text("No formulas found"))
                      : ListView.builder(
                          itemCount: _formulas.length,
                          itemBuilder: (context, index) {
                            final formula = _formulas[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(formula.category[0]), // <-- Show first letter of category
                                backgroundColor: Colors.blueGrey[300],
                              ),
                              title: Text(formula.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Category: ${formula.category}"),
                                  Text("Formula: ${formula.formula}"),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                // <-- REMOVED: Total Stock Value text
              ],
            ),
          ),
        ),
      ),
    );
  }
}