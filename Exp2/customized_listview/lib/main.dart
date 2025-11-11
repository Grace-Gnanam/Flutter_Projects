import 'package:flutter/material.dart';

void main() {
  runApp(MathFormulaApp());
}

class MathFormulaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Formulae Reference',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: FormulaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormulaPage extends StatelessWidget {
  const FormulaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Math Formulae Reference',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.settings),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔍 Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search formula...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔣 Row of icons centered
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.bolt, size: 40, color: Colors.pink),
                  Icon(Icons.square_foot, size: 40, color: Colors.pink),
                  Icon(Icons.functions, size: 40, color: Colors.pink),
                  Icon(Icons.calculate, size: 40, color: Colors.pink),
                ],
              ),
            ),
                        // 🖼️ Image at the top
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                "assets/images/math.png",
                height: 500,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
