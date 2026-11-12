import 'package:flutter/material.dart';
import 'package:spendwise/models/expense.dart';
import 'package:spendwise/widgets/expense_list.dart';
import 'package:spendwise/widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = List.of(sampleExpenses);
  final List<String> _categories = [
    'All',
    'Food',
    'Transport',
    'Bills',
    'Fun',
    
  ];
  String _selectedCategory = 'All';

  List<Expense> get _filteredExpenses {
    if (_selectedCategory == 'All') return _expenses;
    return _expenses.where((e) => e.category == _selectedCategory).toList();
  }

  void _addExpense() {
    setState(() {
      _expenses.insert(
        0,
        Expense(
          title: 'Coffee',
          amount: 3000,
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

  @override
  Widget build(BuildContext context) {
    final visible = _filteredExpenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('SpendWise (${_expenses.length})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Delete all',
            onPressed: () {
              setState(() {
                _expenses.clear();
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final card = SummaryCard(total: totalOf(visible));
          final chips = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _categories.map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: _selectedCategory == cat,
                    onSelected: (_) {
                      setState(() => _selectedCategory = cat);
                    },
                  ),
                );
              }).toList(),
            ),
          );
          final list = ExpenseList(
            expenses: visible,
            onDelete: _deleteExpense,
          );

          if (constraints.maxWidth < 600) {
            return Column(
              children: [
                card,
                chips,
                const SizedBox(height: 8),
                Expanded(child: list),
              ],
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
