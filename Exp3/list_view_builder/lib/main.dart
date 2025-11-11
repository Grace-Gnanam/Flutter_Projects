import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Formula {
  String title;
  String expression;

  Formula({required this.title, required this.expression});
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Formula> formulaList = [
    Formula(title: "Area of Circle", expression: "A = πr²"),
    Formula(title: "Perimeter of Rectangle", expression: "P = 2(l + b)"),
    Formula(title: "Quadratic Formula", expression: "x = (-b ± √(b² - 4ac)) / 2a"),
    Formula(title: "Pythagoras Theorem", expression: "a² + b² = c²"),
    Formula(title: "Simple Interest", expression: "SI = (P × R × T) / 100"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Maths Formulae Reference",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Maths Formulae Reference"),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),

        body: ListView.builder(
          itemCount: formulaList.length,
          itemBuilder: (context, index) {
            final formula = formulaList[index];
            return Column(
              children: [
                SizedBox(height: 10),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    child: Text(formula.title[0]),
                  ),

                  title: Text(formula.title),
                  subtitle: Text(formula.expression),

                  trailing: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(formula.title),
                          content: Text("Formula: ${formula.expression}"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text("View"),
                  ),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${formula.title} selected"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
