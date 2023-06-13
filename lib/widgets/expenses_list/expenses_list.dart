import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

// This class represents a list of expenses in the expense tracker app.
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expenses,
    required this.onRemoveExpense,
    super.key,
  });

  // The list of expenses.
  final List<Expense> expenses;

  // The callback function to remove an expense.
  final void Function(Expense expense) onRemoveExpense;

  // Builds the widget.
  @override
  Widget build(BuildContext context) {
    // Returns a ListView.builder widget with the expenses.
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        // Key for the Dismissible widget.
        key: ValueKey(expenses[index]),
        // Background of the Dismissible widget.
        background: Container(
          // Color of the background.
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          // Margin of the background.
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        // Callback function when the Dismissible widget is dismissed.
        onDismissed: (direction) {
          // Removes the expense from the list.
          onRemoveExpense(expenses[index]);
        },
        // Child of the Dismissible widget.
        child: ExpenseItem(
          // Expense data for the child.
          expense: expenses[index],
        ),
      ),
    );
  }
}
