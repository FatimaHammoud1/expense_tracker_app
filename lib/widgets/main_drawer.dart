import 'package:expense_tracker/screens/filters_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //DrawerHeader: used in a Column widget inside the child of a Drawer. It is optimized to be used in a Drawer to set its header. It is possible to add decoration to set a background colour for the header.
          DrawerHeader(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(167, 155, 39, 176),
                  const Color.fromARGB(57, 155, 39, 176),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.payments, size: 45),
                SizedBox(height: 20),
                Text(
                  'Expense Tracker',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          //ListTile to list the Drawer actions.
          //ListTile can be used in any list not onlyDrawers.
          //▪ title: to set the text of the tile
          //▪ leading: to set a widget to be positioned before the title. Usually used for an icon.
          //▪ onTap: to set the action of this tile. Usually used to navigate to a new screen.
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Filters'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => FiltersScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
