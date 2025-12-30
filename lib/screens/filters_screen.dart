import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _workFilterSet = false;
  var _leisureFilterSet = false;
  var _foodFilterSet = false;
  var _travelFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Filters')),

      // PopScope : A widget that listens to back navigation
      // Triggered when:
      // Back arrow is pressed
      // System back button is pressed
      // Navigator.pop() is called
      body: PopScope(
        //canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          result = {
            Category.food: _foodFilterSet,
            Category.leisure: _leisureFilterSet,
            Category.work: _workFilterSet,
            Category.travel: _travelFilterSet,
          };
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _workFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _workFilterSet = isChecked;
                });
              },
              title: Text('Work'),
              subtitle: Text('Only include work expenses.'),
              activeColor: const Color.fromARGB(118, 155, 39, 176),
              contentPadding: EdgeInsets.only(left: 30, right: 20),
            ),
            SwitchListTile(
              value: _leisureFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _leisureFilterSet = isChecked;
                });
              },
              title: Text('Leisure'),
              subtitle: Text('Only include leisure expenses.'),
              activeColor: const Color.fromARGB(118, 155, 39, 176),
              contentPadding: EdgeInsets.only(left: 30, right: 20),
            ),
            SwitchListTile(
              value: _foodFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _foodFilterSet = isChecked;
                });
              },
              title: Text('Food'),
              subtitle: Text('Only include food expenses.'),
              activeColor: const Color.fromARGB(118, 155, 39, 176),
              contentPadding: EdgeInsets.only(left: 30, right: 20),
            ),
            SwitchListTile(
              value: _travelFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _travelFilterSet = isChecked;
                });
              },
              title: Text('Travel'),
              subtitle: Text('Only include travel expenses.'),
              activeColor: const Color.fromARGB(118, 155, 39, 176),
              contentPadding: EdgeInsets.only(left: 30, right: 20),
            ),
          ],
        ),
      ),
    );
  }
}
