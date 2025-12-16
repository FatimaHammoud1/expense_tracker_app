import 'package:expense_tracker/db/database.dart';
import 'package:expense_tracker/models/expense.dart';

void insertExpense(Expense expense) async {
  // get an instance of the database
  ExpenseDatabase database = ExpenseDatabase();
  final db = await database.getDatabase();
  // insert expense into the database
  db.insert('expenses', expense.expenseMap);
}

Future<List<Expense>> loadExpenses() async {
  // get an instance of the database
  ExpenseDatabase database = ExpenseDatabase();
  final db = await database.getDatabase();
  // get all expenses from the database
  final result = await db.query('expenses');
  // map every row into an Expense object
  List<Expense> resultList = result.map((row) {
    return Expense(
      // cast every object into its corresponding type
      id: row['id'] as String,
      amount: row['amount'] as double,
      title: row['title'] as String,
      // covert the date int from milliseconds to a DateTime object
      date: DateTime.fromMillisecondsSinceEpoch(row['date'] as int),
      //convert every category string into type Category enum
      // Use ! at the end of the variable name to tell Dart not to check for null values
      category: categoryName[row['category'] as String]!,
    );
  }).toList();
  // return the resulting expenses list
  return resultList;
}

void deleteExpense(Expense expense) async {
  // get an instance of the database
  ExpenseDatabase database = ExpenseDatabase();
  final db = await database.getDatabase();
  // delete an expense with a specific id
  db.delete('expenses', where: 'id = ?', whereArgs: [expense.id]);
}
