import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/category_chips.dart';
import '../widgets/expense_list.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // The state of this screen:
  final List<Expense> _expenses = [...sampleExpenses];
  String _category = 'All';

  // Only the expenses of the selected category.
  List<Expense> _filtered() {
    if (_category == 'All') return _expenses;
    final result = <Expense>[];
    for (final e in _expenses) {
      if (e.category == _category) result.add(e);
    }
    return result;
  }

  void _addExpense() {
    setState(() {
      _expenses.insert(
        0,
        Expense(
          title: 'Coffee',
          amount: 2000,
          category: 'Food',
          date: DateTime.now(),
        ),
      );
    });
  }

  void _deleteExpense(Expense expense) {
    setState(() {
      _expenses.remove(expense);
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _category = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _filtered();
    final card = SummaryCard(total: totalOf(visible));
    final chips = CategoryChips(
      selected: _category,
      onSelected: _selectCategory,
    );
    final list = ExpenseList(
      expenses: visible,
      onDelete: _deleteExpense,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('SpendWise'),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Column(
              children: [card, chips, Expanded(child: list)],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 360,
                child: Column(children: [card, chips]),
              ),
              Expanded(child: list),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
