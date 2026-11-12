import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expense_tile.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final ValueChanged<Expense> onDelete;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
          child: expenses.isEmpty
              ? const Center(child: Text('No expenses yet'))
              : ListView(
                  children: [
                    for (final e in expenses)
                      ExpenseTile(
                        expense: e,
                        onDelete: () => onDelete(e),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
