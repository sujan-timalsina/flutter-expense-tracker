import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// This class represents a single expense item in the expense tracker app.
class ExpenseItem extends StatelessWidget {
  // Constructor.
  const ExpenseItem({
    required this.expense,
    super.key,
  });

  // The expense data for this item.
  final Expense expense;

  // Builds the widget.
  @override
  Widget build(BuildContext context) {
    // Returns a Card widget with the expense data.
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text.
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // 4px vertical space.
            const SizedBox(height: 4),
            // Row of expense amount, category icon, and date.
            Row(
              children: [
                // Expense amount text.
                Text('Rs. ${expense.amount.toStringAsFixed(2)}'),
                // Spacer widget to fill the remaining horizontal space.
                const Spacer(),
                // Row of category icon and date.
                Row(
                  children: [
                    // Category icon.
                    Icon(categoryIcons[expense.category]),
                    // 8px horizontal space.
                    const SizedBox(width: 8),
                    // Date text.
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
