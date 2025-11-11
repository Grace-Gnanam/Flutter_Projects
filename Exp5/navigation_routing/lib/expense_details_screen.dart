import 'package:flutter/material.dart';
import 'expense_data_model.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _formkey = GlobalKey<FormState>();

  final _incomeCtrl = TextEditingController();
  final _rentCtrl = TextEditingController();
  final _foodCtrl = TextEditingController();
  final _transportCtrl = TextEditingController();
  final _otherCtrl = TextEditingController();

  final Color purple = const Color(0xFF7A3FFF);

  InputDecoration purpleField(String label) => InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: purple),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: purple, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Input Form"),
        backgroundColor: purple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _incomeCtrl,
                  keyboardType: TextInputType.number,
                  decoration: purpleField("Monthly Income (₹)"),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Enter your income";
                    if (double.tryParse(v) == null || double.parse(v) <= 0) {
                      return "Enter a valid positive number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _rentCtrl,
                  keyboardType: TextInputType.number,
                  decoration: purpleField("Rent / EMI (₹)"),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Enter your rent/EMI";
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _foodCtrl,
                  keyboardType: TextInputType.number,
                  decoration: purpleField("Food Expenses (₹)"),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Enter food expenses";
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _transportCtrl,
                  keyboardType: TextInputType.number,
                  decoration: purpleField("Transport Expenses (₹)"),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Enter transport expenses";
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _otherCtrl,
                  keyboardType: TextInputType.number,
                  decoration: purpleField("Other Monthly Expenses (₹)"),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Enter other expenses";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      final expense = Expense(
                        income: double.parse(_incomeCtrl.text),
                        rentEmi: double.parse(_rentCtrl.text),
                        food: double.parse(_foodCtrl.text),
                        transport: double.parse(_transportCtrl.text),
                        other: double.parse(_otherCtrl.text),
                      );

                      Navigator.pushNamed(
                        context,
                        '/result',
                        arguments: expense,
                      );
                    }
                  },
                  child: const Text("Calculate Budget"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
