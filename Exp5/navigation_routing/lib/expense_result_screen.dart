import 'package:flutter/material.dart';
import 'expense_data_model.dart';

class ExpenseResultScreen extends StatelessWidget {
  const ExpenseResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expense = ModalRoute.of(context)!.settings.arguments as Expense;

    final double balance = expense.income -
        (expense.rentEmi + expense.food + expense.transport + expense.other);

    final Color purple = const Color(0xFF7A3FFF);

    Widget expenseCard(String title, double value, IconData icon) {
      return Card(
        elevation: 3,
        child: ListTile(
          leading: Icon(icon, color: purple),
          title: Text(title),
          subtitle: Text("₹ ${value.toStringAsFixed(2)}"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Analysis"),
        backgroundColor: purple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            expenseCard("Monthly Income", expense.income, Icons.wallet),
            expenseCard("Rent / EMI", expense.rentEmi, Icons.home),
            expenseCard("Food Expenses", expense.food, Icons.restaurant),
            expenseCard("Transport Expenses", expense.transport, Icons.directions_bus),
            expenseCard("Other Expenses", expense.other, Icons.shopping_cart),

            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: purple),
                title: const Text("Remaining Balance"),
                subtitle: Text(
                  "₹ ${balance.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: balance >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  balance >= 0 ? "Good" : "Overspending!",
                  style: TextStyle(
                    color: balance >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
