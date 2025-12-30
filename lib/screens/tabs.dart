import 'package:expense_tracker/db/expense_storage.dart';
import 'package:expense_tracker/expenses_app.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/chart.dart';
import 'package:expense_tracker/widgets/main_drawer.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.expensesList});

  final List<Expense> expensesList;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addNewExpense),
    );
  }

  void _addNewExpense(Expense expense) async {
    setState(() {
      // now, when you want to use registeredExpensesList in the State class, you use the widget varaible
      widget.expensesList.add(expense);
    });
    // insert the new expense to the database
    insertExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = ExpensesApp(
      registeredExpensesList: widget.expensesList,
    );
    var activeAppBar = AppBar(
      title: Text('Expenses List'),
      actions: [
        IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
      ],
    );
    if (_selectedIndex == 1) {
      activePage = ChartScreen();
      activeAppBar = AppBar(title: Text('Expenses Chart'));
    }
    return Scaffold(
      appBar: activeAppBar,
      body: activePage,
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Chart',
          ),
        ],
        onTap: _selectPage,
        currentIndex: _selectedIndex,
      ),
    );
  }
}


// In the Scaffold widget add the bottomNavigationBar.
 
// To save the currently selected page, you
// create an index variable. An if statement is then used in the build method to change the active
// page based on the selected index.

// • bottomNavigationBar: BottomNavigationBar(), a parameter set in the Scaffold Widget
// o onTap: a function executed when the user selects a tab. It receives the index of
// the tab. This method will call the setState method that changes the index of the
// displayed page.
// o items of type List<BottomNavigationBarItem>: the list of tabs. Every tab item
// needs an icon, and you can set a label.


// o currentIndex: set to the selected page index. This controls which tab will be
// highlighted.
// o By changing the page index, the AppBar and body of the Scaffold can be set
// dynamically.

// This same class, should be Stateful, and if it displays a list of data in one of its pages, it should
// contain all the methods that change this list of data.
