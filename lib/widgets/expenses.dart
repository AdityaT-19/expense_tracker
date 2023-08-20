import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensePage();
  }
}

class _ExpensePage extends State<Expenses> {
  final List<Expense> expensesList = [
    Expense(
        title: 'course',
        amt: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'sm-nwh',
        amt: 15.04,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(_addExp),
    );
  }

  void _addExp(Expense exp) {
    setState(() {
      expensesList.add(exp);
    });
  }

  void _rmExp(Expense exp) {
    final expIndex = expensesList.indexOf(exp);
    setState(
      () {
        expensesList.remove(exp);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense Deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                expensesList.insert(expIndex, exp);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hieght = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(child: Text('No Expenes Add few'));
    if (expensesList.isNotEmpty) {
      setState(() {
        mainContent = ExpenseList(expensesList, _rmExp);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < hieght
          ? Column(
              children: [
                Chart(expenses: expensesList),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: expensesList)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
