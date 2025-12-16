import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({required this.expense, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(expense.title),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              "\$${expense.amount.toStringAsFixed(2)}", //Use \ as a skipping operator to insert the $ before amount.
            ), //To show two floating point digits from the amount double value
            Spacer(),
            Row(
              children: [
                Icon(categoryIcon[expense.category]),
                SizedBox(width: 8),
                Text(expense.formattedDate),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
