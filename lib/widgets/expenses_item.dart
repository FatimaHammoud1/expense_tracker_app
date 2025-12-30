import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/expense_details.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({required this.expense, super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Text(expense.title),
    //     SizedBox(height: 4),
    //     Row(
    //       children: [
    //         Text(
    //           "\$${expense.amount.toStringAsFixed(2)}", //Use \ as a skipping operator to insert the $ before amount.
    //         ), //To show two floating point digits from the amount double value
    //         Spacer(),
    //         Row(
    //           children: [
    //             Icon(categoryIcon[expense.category]),
    //             SizedBox(width: 8),
    //             Text(expense.formattedDate),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ],
    // );

    return Card(
      // InkWell used to make any widget tappable. GestureDetector can be used as well, however the
      // InkWell adds a visual effect when the widget is tapped.
      // • splashColor allows to show a color when the item is tapped. splashColor: const
      // Color.fromARGB(96, 155, 39, 176)
      // • borderRadius adds a border radius shape for the InkWell effect. borderRadius:
      // BorderRadius.circular(12)
      child: InkWell(
        splashColor: const Color.fromARGB(108, 155, 39, 176),
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => ExpenseDetails(expense: expense),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                expense.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${expense.amount.toStringAsFixed(2)}"),
                  //Spacer(),
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
          ),
        ),
      ),
    );
  }
}
