import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseTile({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(iconFor(expense.category))),
      title: Text(expense.title),
      subtitle: Text(expense.category),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatIqd(expense.amount),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

IconData iconFor(String category) {
  switch (category) {
    case 'Food':
      return Icons.restaurant;
    case 'Transport':
      return Icons.directions_bus;
    case 'Bills':
      return Icons.receipt_long;
    case 'Fun':
      return Icons.celebration;
    default:
      return Icons.payments;
  }
}
