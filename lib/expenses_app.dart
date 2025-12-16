import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  final List<Expense> _registeredExpensesList = [
    Expense(
      title: 'Burger',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled:
          true, //We want to make sure that the TextField keyboard does not hide the inputs.
      context: context,
      builder: (ctx) =>
          Padding(padding: EdgeInsets.all(16), child: NewExpense(_addExpense)),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpensesList.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    int index = _registeredExpensesList.indexOf(expense);
    setState(() {
      _registeredExpensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpensesList.insert(index, expense);
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
    if (_registeredExpensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _registeredExpensesList,
        onDeleteExpense: _deleteExpense,
      );
    }
    return Scaffold(
      body: Center(child: mainContent),
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
