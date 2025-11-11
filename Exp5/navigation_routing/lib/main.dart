import 'package:flutter/material.dart';
import 'expense_details_screen.dart';
import 'expense_result_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "Monthly Budget Analyzer",
    theme: ThemeData(
      primaryColor: const Color(0xFF7A3FFF),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A3FFF)),
      useMaterial3: true,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => ExpenseScreen(),
      '/result': (context) => ExpenseResultScreen(),
    },
  ));
}
