import 'package:expense_tracker/expenses_app.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:expense_tracker/db/expense_storage.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // a line required before any async code in main
  WidgetsFlutterBinding.ensureInitialized();
  // Change the database factory if you are running a windows application
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  // Load the expenses from the database
  List<Expense> expensesList = await loadExpenses();
  // pass the loaded expenses to MyApp, which will pass it to ExpensesApp

  runApp(MainApp(registeredExpensesList: expensesList));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.registeredExpensesList});

  final List<Expense> registeredExpensesList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpensesApp(registeredExpensesList: registeredExpensesList),
    );
  }
}
