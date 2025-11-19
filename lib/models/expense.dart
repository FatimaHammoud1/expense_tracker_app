import 'package:uuid/uuid.dart';

class Expense {
  final String id = Uuid().v4();
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}

enum Category { food, work, leisure, travel }
