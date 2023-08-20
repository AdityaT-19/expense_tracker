import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.expenses, this.rmExp, {super.key});
  final void Function(Expense) rmExp;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          rmExp(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
