import 'dart:math';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(expense.title)),
      body: Text(expense.title),
    );
  }
}
