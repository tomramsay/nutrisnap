import 'package:flutter/material.dart';

/// Animated number counter that smoothly transitions between values.
///
/// Used for calorie counts, macro values, and streak numbers.
class AnimatedCounter extends StatelessWidget {
  final num value;
  final TextStyle? style;
  final Duration duration;
  final String suffix;
  final int decimalPlaces;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 800),
    this.suffix = '',
    this.decimalPlaces = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        final text = decimalPlaces > 0
            ? animatedValue.toStringAsFixed(decimalPlaces)
            : animatedValue.toInt().toString();
        return Text(
          '$text$suffix',
          style: style ?? Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
