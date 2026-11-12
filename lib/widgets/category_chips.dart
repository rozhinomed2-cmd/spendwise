import 'package:flutter/material.dart';

const List<String> categories = [
  'All', 'Food', 'Transport', 'Bills', 'Fun',
];

// A row of chips. It does not store the selection itself:
// the parent passes it in and is told when it changes.
class CategoryChips extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Wrap(
        spacing: 8,
        children: [
          for (final c in categories)
            ChoiceChip(
              label: Text(c),
              selected: c == selected,
              onSelected: (_) => onSelected(c),
            ),
        ],
      ),
    );
  }
}
