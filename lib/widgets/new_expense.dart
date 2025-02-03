import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void setSelectedCategory(Category? category) {
    if (category == null) {
      return;
    }
    setState(() {
      _selectedCategory = category;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text) ?? 0.0;
    final amountIsInvalid = enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var choenDate = _selectedDate == null
        ? 'No date chosen'
        : dateFormatter.format(_selectedDate!);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(labelText: 'Title'),
          keyboardType: TextInputType.text,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '£ ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(choenDate),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month))
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DropdownButton(
              value: _selectedCategory,
              items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setSelectedCategory(value as Category),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                _submitExpenseData;
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        )
      ]),
    );
  }
}
