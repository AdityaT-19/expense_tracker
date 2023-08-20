import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, leisure, work, travel }

const CategoryIcon = {
  Category.food: Icons.food_bank,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amt,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amt;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.cat, required this.expenses});
  ExpenseBucket.forCat(List<Expense> allExp, this.cat)
      : expenses = allExp
            .where(
              (exp) => exp.category == cat,
            )
            .toList();
  final Category cat;
  final List<Expense> expenses;
  double get sumAmt {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amt;
    }
    return sum;
  }
}
