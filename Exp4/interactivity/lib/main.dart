import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final _formkey = GlobalKey<FormState>();
  final _amountcontroller = TextEditingController();
  final _interestcontroller = TextEditingController();
  final _tenurecontroller = TextEditingController();

  String _result = "";

  void _calculateEmi() {
    if (_formkey.currentState!.validate()) {
      double p = double.tryParse(_amountcontroller.text) ?? 0.0;
      double annualInterest = double.tryParse(_interestcontroller.text) ?? 0.0;
      double r = annualInterest / 12 / 100;
      int n = int.tryParse(_tenurecontroller.text) ?? 0;

      double emi;
      if (r == 0) {
        emi = p / n;
      } else {
        emi = (p * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
      }

      double totalInterest = (emi * n) - p;

      setState(() {
        _result =
            "💰 Loan Amount : ₹ ${p.toStringAsFixed(2)}\n"
            "📌 EMI Amount : ₹ ${emi.toStringAsFixed(2)}\n"
            "📈 Total Interest : ₹ ${totalInterest.toStringAsFixed(2)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF7A3FFF);

    return MaterialApp(
      title: "EMI Calculator App",
      home: Scaffold(
        backgroundColor: const Color(0xFFF3E9FF),
        appBar: AppBar(
          title: Text("EMI Calculator"),
          backgroundColor: purple,
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [

                // --- Loan Amount Field ---
                TextFormField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Loan Amount",
                    labelStyle: TextStyle(color: purple),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter loan amount";
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return "Enter valid positive number";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),

                // --- Interest Rate Field ---
                TextFormField(
                  controller: _interestcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Annual Interest Rate (%)",
                    labelStyle: TextStyle(color: purple),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter interest rate";
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return "Enter valid positive number";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),

                // --- Tenure Field ---
                TextFormField(
                  controller: _tenurecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Loan Tenure (Months)",
                    labelStyle: TextStyle(color: purple),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: purple, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter loan tenure";
                    }
                    if (int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return "Enter valid positive number";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                // --- Calculate Button ---
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _calculateEmi,
                  child: Text("Calculate EMI"),
                ),

                SizedBox(height: 25),

                // --- Result Box ---
                if (_result.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: purple, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Text(
                      _result,
                      style: TextStyle(
                        color: purple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
