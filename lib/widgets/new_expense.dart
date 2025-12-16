import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) addExpense;
  const NewExpense(this.addExpense, {super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var expenseTitle;
  // void _saveExpenseTitle(String input) {
  //   expenseTitle = input;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
      context: context,
      initialDate:
          now, //This is the date that the date picker shows when it first opens.
      firstDate: firstDate, //This is the earliest allowed date you can pick.
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseForm() {
    var enteredAmount = double.tryParse(
      _amountController.text,
    ); //This method converts a text into a double and returns it.
    var amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //trim removes any leading and trailing spaces from the text.
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text(
            "This method converts a text into a double and returns it",
          ),
          actions: [
            //actions: allow to display buttons to perform actions.
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Close"),
            ),
          ],
        ),
      );
      return;
    }
    var newExpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.addExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            decoration: InputDecoration(label: Text("Expense Title")),
            // onChanged: _saveExpenseTitle,
            controller: _titleController,
          ), //allow the user to set the expense title.
          // Row(
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         print(_titleController.text);
          //       },
          //       child: Text("Save Expense"),
          //     ),
          //   ],
          // ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Expense Amount"),
                  ),
                  // onChanged: _saveExpenseTitle,
                  controller: _amountController,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ), //allow the user to set the expense title.
          SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value:
                    _selectedCategory, //To show the selected category text on the DropDownButton,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  ); //Use the Navigator class which allow to control how we navigate in our app. This class contains the pop method that removes the overlay from the screen. It takes in the context parameter that is passed in to the build function.
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenseForm,
                child: Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
