import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

// This class represents the expenses screen.
class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
    required this.isDarkMode,
    required this.onChangeThemeMode,
  });

  // The current theme mode.
  final bool isDarkMode;

  // The function to change the theme mode.
  final void Function(bool isDarkMode) onChangeThemeMode;

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

// This class represents the state for the expenses screen.
class _ExpensesState extends State<Expenses> {
  // The list of registered expenses.
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Cinema',
      amount: 500,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  // This function opens the add expense overlay.
  void _openAddExpenseOverlay() {
    // Show the modal bottom sheet.
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  // This function adds an expense to the list of registered expenses.
  void _addExpense(Expense expense) {
    // Update the state of the list of registered expenses.
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // This function removes an expense from the list of registered expenses with undo feature.
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  // This function builds the widget for the expenses screen.
  @override
  Widget build(BuildContext context) {
    // Get the width of the screen.
    final width = MediaQuery.of(context).size.width;

    // The main content of the expenses screen if expenses is empty.
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    // The main content of the expenses screen if expenses is not empty.
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              widget.onChangeThemeMode(!widget.isDarkMode);
            },
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
