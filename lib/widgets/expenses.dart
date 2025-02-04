import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 50.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Train Ticket',
      amount: 20.0,
      date: DateTime(2025, 1, 30),
      category: Category.travel,
    ),
    Expense(
      title: 'Dinner',
      amount: 30.0,
      date: DateTime(2025, 1, 28),
      category: Category.leisure,
    ),
    Expense(
      title: 'Laptop',
      amount: 1000.0,
      date: DateTime(2025, 1, 17),
      category: Category.work,
    ),
  ];

  _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext showModalBottomSheetContext) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 132, 207, 245),
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}
