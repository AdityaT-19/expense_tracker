import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(this.addExp, {super.key});
  final void Function(Expense) addExp;
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amtController = TextEditingController();
  DateTime? date;
  Category selCat = Category.food;

  void showCalender() async {
    final initalDate = DateTime.now();
    final firstDate =
        DateTime(initalDate.year - 1, initalDate.month, initalDate.day);
    final lastDate =
        DateTime(initalDate.year, initalDate.month, initalDate.day);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initalDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      date = selectedDate;
    });
  }

  void submitExp() {
    final amt = double.tryParse(amtController.text);
    final amtInvalid = amt == null || amt <= 0;
    final title = titleController.text.trim();
    if (title.isEmpty || amtInvalid || date == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please verify the Title, Amount, Date and Category selected....'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    setState(
      () {
        final expense = Expense(
          title: title,
          amt: amt,
          date: date!,
          category: selCat,
        );
        widget.addExp(expense);
      },
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSize = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSize + 16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                maxLength: 50,
                onSubmitted: (value) {
                  print(value);
                },
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amtController,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          date == null
                              ? 'No date Selected'
                              : formatter.format(date!),
                        ),
                        IconButton(
                          onPressed: showCalender,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  DropdownButton(
                    value: selCat,
                    items: Category.values
                        .map(
                          (cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(
                              cat.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selCat = value;
                      });
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: submitExp,
                    child: const Text("Save Expense"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
