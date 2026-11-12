import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expense_tile.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense)? onDelete;

  const ExpenseList({
    super.key,
    required this.expenses,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text('No expenses yet. Tap + to add one.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recent Expenses',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final e = expenses[index];
              return Dismissible(
                key: ValueKey('${e.title}-${e.date}-$index'),
                onDismissed: (_) => onDelete?.call(e),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ExpenseTile(expense: e),
              );
            },
          ),
        ),
      ],
    );
  }
}
