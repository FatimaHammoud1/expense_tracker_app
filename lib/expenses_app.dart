import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/db/expense_storage.dart';

class ExpensesApp extends StatefulWidget {
  // registeredExpensesList is not anymore a private fixed list, it is now loaded from the database and passed to ExpenseApp from main.dart
  const ExpensesApp({super.key, required this.registeredExpensesList});
  final List<Expense> registeredExpensesList;
  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  void _deleteExpense(Expense expense) {
    int index = widget.registeredExpensesList.indexOf(expense);
    setState(() {
      widget.registeredExpensesList.remove(expense);
      // delete the expense from the database
      deleteExpense(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              widget.registeredExpensesList.insert(index, expense);
              // insret the expense again if the user revert the action
              insertExpense(expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          'No expenses found! Add some to see them here.',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
    );
    if (widget.registeredExpensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: widget.registeredExpensesList,
        onDeleteExpense: _deleteExpense,
      );
    }
    return Scaffold(body: Center(child: mainContent));
  }
}
