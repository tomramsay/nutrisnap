import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_typography.dart';

/// Compact nutrient badge showing value, unit, and label.
///
/// Used in meal cards, daily summaries, etc.
class NutrientBadge extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;
  final double? progress;

  const NutrientBadge({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.s12,
        vertical: AppSizes.s10,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: color.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: AppSizes.s4),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTypography.nutrientValue.copyWith(color: color),
              ),
              const SizedBox(width: AppSizes.s2),
              Text(
                unit,
                style: AppTypography.nutrientUnit.copyWith(
                  color: color.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: AppSizes.s6),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              child: LinearProgressIndicator(
                value: progress!.clamp(0.0, 1.0),
                backgroundColor: color.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
