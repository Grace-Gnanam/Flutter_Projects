import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

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
  final List<Map<String, dynamic>> formulas = [
    {
      "title": "Einstein’s Energy Equation",
      "icon": Icons.bolt,
      "formula": r"E = mc^2"
    },
    {
      "title": "Pythagoras Theorem",
      "icon": Icons.square_foot,
      "formula": r"a^2 + b^2 = c^2"
    },
    {
      "title": "Definite Integral",
      "icon": Icons.integration_instructions,
      "formula": r"\int_a^b f(x)\,dx = F(b) - F(a)"
    },
    {
      "title": "Quadratic Formula",
      "icon": Icons.functions,
      "formula": r"x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}"
    },
    {
      "title": "Trigonometric Identity",
      "icon": Icons.calculate,
      "formula": r"\sin^2\theta + \cos^2\theta = 1"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Math Formulae Reference',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
  children: [
    // 🔎 Search bar
    Padding(
      padding: const EdgeInsets.all(12.0),
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

    // 📐 Centered content area
    Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,   // center horizontally
          crossAxisAlignment: CrossAxisAlignment.center, // center vertically
          children: [
            // Left image
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(
                    "assets/images/math.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Right formula list
            Expanded(
              flex: 2,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true, // 👈 prevents full-height stretching
                  padding: EdgeInsets.all(16),
                  itemCount: formulas.length,
                  itemBuilder: (context, index) {
                    final item = formulas[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(item["icon"], size: 36, color: Colors.pink),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["title"],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Math.tex(
                                    item["formula"],
                                    textStyle: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),

    );
  }
}
