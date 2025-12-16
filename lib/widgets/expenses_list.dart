import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  final void Function(Expense expense) onDeleteExpense;
  const ExpensesList({
    required this.expensesList,
    required this.onDeleteExpense,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Card(
        //To style every list item we use the Card widget. It is a Material Design card that have a slightly rounded corners and elevated shadow.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Dismissible(
            background: Container(
              padding: EdgeInsets.only(left: 12),
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete, color: Colors.white, size: 25),
            ),
            key: ValueKey(expensesList[index]),
            child: ExpenseItem(expense: expensesList[index]),
            onDismissed: (direction) {
              onDeleteExpense(expensesList[index]);
            },
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                  title: Text('Delete Expense'),
                  content: Text(
                    'Are you sure you want to delete this expense?',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// key: an object user to uniquely identify every widget. We often do not need to
// use/set this key, but this widget requires to set it. This key is created using the
// ValueKey(expensesList[index]) object which takes in any unique value. We set it
// to the current expense object itself because it is a unique object.
