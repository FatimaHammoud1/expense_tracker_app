import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    // use the initializer list to set the id to a unique id,
    // or to the id retreived from the database
    // ?? checks if the parameter id is null or not
    id,
  }) : id = id ?? Uuid().v4();

  String get formattedDate {
    return DateFormat.yMd().format(date);
  }

  // Create a getter to create a map for every expense object.
  // This map is used to insert data into the database.
  Map<String, Object?> get expenseMap {
    return {
      'id': id,
      'amount': amount,
      'title': title,
      'category': category.name,
      'date': date.millisecondsSinceEpoch,
    };
  }
}

enum Category { food, work, leisure, travel }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// Create a map to convert every string to a Category enum
const categoryName = {
  'food': Category.food,
  'leisure': Category.leisure,
  'work': Category.work,
  'travel': Category.travel,
};
