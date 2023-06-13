import 'package:flutter/material.dart';

// A widget that represents a chart bar.
class ChartBar extends StatelessWidget {
  /// Creates a chart bar.
  ///
  /// The [fill] property determines the height of the bar.
  const ChartBar({
    super.key,
    required this.fill,
  });

  /// The height of the bar.
  final double fill;

  @override
  Widget build(BuildContext context) {
    /// Gets the current brightness mode.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    /// Returns a widget that expands to fill its parent.
    return Expanded(
      child: Padding(
        /// Padding around the bar.
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          /// The height of the bar is proportional to the [fill] property.
          heightFactor: fill, // 0 <> 1
          child: DecoratedBox(
            decoration: BoxDecoration(
              /// The shape of the bar is a rectangle.
              shape: BoxShape.rectangle,

              /// The border radius of the bar is rounded at the top.
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),

              /// The color of the bar is determined by the current brightness mode.
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
