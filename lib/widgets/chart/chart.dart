import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

/// A widget that displays a chart of expenses.
class Chart extends StatelessWidget {
  /// Creates a chart.
  ///
  /// The [expenses] property is a list of expenses.
  const Chart({super.key, required this.expenses});

  /// The list of expenses.
  final List<Expense> expenses;

  /// Returns a list of expense buckets.
  ///
  /// An expense bucket is a group of expenses that belong to the same category.
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  /// Returns the maximum total expense.
  ///
  /// The maximum total expense is the total expense of the largest expense bucket.
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    // Gets the current brightness mode.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    // Returns a container that contains the chart.
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          // Expands to fill its parent and aligns its children to the end.
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Loops through the buckets and creates a chart bar for each one.
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    // Fills the chart bar with the bucket's total expenses divided by the maximum total expense.
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          // Creates a spacer that is 12 pixels high.
          const SizedBox(height: 12),
          // Loops through the buckets and creates an icon for each one.
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        // Gets the icon for the bucket's category.
                        categoryIcons[bucket.category],
                        // Colors the icon based on the current brightness mode.
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
