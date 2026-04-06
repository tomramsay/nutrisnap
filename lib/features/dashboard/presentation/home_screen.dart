import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/animated_counter.dart';
import '../../../shared/widgets/nutrient_badge.dart';

/// Main dashboard / home screen.
///
/// Displays:
/// - Greeting + streak
/// - Calorie progress ring
/// - Macro progress bars
/// - Water tracker
/// - Today's meal timeline
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good afternoon 👋',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
            Text(
              'Jane',
              style: AppTypography.headlineMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          // Streak badge
          Container(
            margin: const EdgeInsets.only(right: AppSizes.s16),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s12,
              vertical: AppSizes.s6,
            ),
            decoration: BoxDecoration(
              color: AppColors.calories.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              border: Border.all(
                color: AppColors.calories.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  color: AppColors.calories,
                  size: 18,
                ),
                const SizedBox(width: AppSizes.s4),
                Text(
                  '12',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.calories,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingH,
          vertical: AppSizes.s8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Calorie Ring Card ───
            _buildCalorieCard(context),
            const SizedBox(height: AppSizes.s16),

            // ─── Macros Row ───
            Row(
              children: [
                Expanded(
                  child: NutrientBadge(
                    label: 'Protein',
                    value: '132',
                    unit: 'g',
                    color: AppColors.protein,
                    progress: 0.92,
                  ),
                ),
                const SizedBox(width: AppSizes.s10),
                Expanded(
                  child: NutrientBadge(
                    label: 'Carbs',
                    value: '165',
                    unit: 'g',
                    color: AppColors.carbs,
                    progress: 0.85,
                  ),
                ),
                const SizedBox(width: AppSizes.s10),
                Expanded(
                  child: NutrientBadge(
                    label: 'Fat',
                    value: '52',
                    unit: 'g',
                    color: AppColors.fat,
                    progress: 0.78,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.s16),

            // ─── Water Tracker ───
            _buildWaterCard(context),
            const SizedBox(height: AppSizes.s24),

            // ─── Today's Meals ───
            Text(
              "Today's Meals",
              style: AppTypography.headlineSmall.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSizes.s12),

            _buildMealCard(
              context,
              time: '8:15 AM',
              type: 'Breakfast',
              foods: 'Greek Yogurt Parfait, Banana',
              calories: 420,
              icon: Icons.wb_sunny_outlined,
              iconColor: AppColors.secondary,
            ),
            const SizedBox(height: AppSizes.s10),
            _buildMealCard(
              context,
              time: '12:35 PM',
              type: 'Lunch',
              foods: 'Grilled Chicken, Brown Rice, Salad',
              calories: 464,
              icon: Icons.restaurant_outlined,
              iconColor: AppColors.primary,
            ),
            const SizedBox(height: AppSizes.s10),
            _buildMealCard(
              context,
              time: '3:00 PM',
              type: 'Snack',
              foods: 'Apple, Almond Butter',
              calories: 146,
              icon: Icons.coffee_outlined,
              iconColor: AppColors.carbs,
            ),

            const SizedBox(height: AppSizes.s80),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieCard(BuildContext context) {
    const consumed = 1650;
    const target = 1800;
    const remaining = target - consumed;
    const progress = consumed / target;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.s24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkSurface,
            AppColors.primaryContainer.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        border: Border.all(
          color: AppColors.darkSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Ring
          SizedBox(
            width: AppSizes.calorieRingSize,
            height: AppSizes.calorieRingSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: AppSizes.calorieRingSize,
                  height: AppSizes.calorieRingSize,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return CustomPaint(
                        painter: _CalorieRingPainter(
                          progress: value,
                          strokeWidth: AppSizes.calorieRingStroke,
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedCounter(
                      value: remaining,
                      style: AppTypography.calorieRingValue.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'remaining',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.s24),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calories',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
                const SizedBox(height: AppSizes.s8),
                _buildCalorieRow('Consumed', '$consumed', AppColors.primary),
                const SizedBox(height: AppSizes.s6),
                _buildCalorieRow('Target', '$target', AppColors.darkTextSecondary),
                const SizedBox(height: AppSizes.s6),
                _buildCalorieRow('Remaining', '$remaining', AppColors.primaryLight),
                const SizedBox(height: AppSizes.s12),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}% of daily goal',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.darkTextSecondary,
          ),
        ),
        Text(
          '$value kcal',
          style: AppTypography.titleSmall.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildWaterCard(BuildContext context) {
    const current = 1800;
    const target = 2500;
    const progress = current / target;
    const glasses = current ~/ 250;

    return Container(
      padding: const EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: AppColors.water.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(
          color: AppColors.water.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.water_drop_rounded,
            color: AppColors.water,
            size: 32,
          ),
          const SizedBox(width: AppSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Water',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.water,
                      ),
                    ),
                    Text(
                      '${current}ml / ${target}ml',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.water.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.s8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return LinearProgressIndicator(
                        value: value,
                        backgroundColor: AppColors.water.withValues(alpha: 0.15),
                        valueColor: const AlwaysStoppedAnimation(AppColors.water),
                        minHeight: 8,
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.s4),
                Text(
                  '$glasses glasses • ${(progress * 100).toStringAsFixed(0)}%',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.darkTextTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.s8),
          IconButton(
            onPressed: () {
              // TODO: Add 250ml
            },
            icon: const Icon(Icons.add_circle_rounded),
            color: AppColors.water,
            iconSize: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(
    BuildContext context, {
    required String time,
    required String type,
    required String foods,
    required int calories,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(
          color: AppColors.darkSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: AppSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type,
                      style: AppTypography.titleSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$calories kcal',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.s2),
                Text(
                  foods,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSizes.s2),
                Text(
                  time,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.darkTextTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.s8),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.darkTextTertiary,
            size: 20,
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the animated calorie ring.
class _CalorieRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _CalorieRingPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background ring
    final bgPaint = Paint()
      ..color = AppColors.darkSurfaceVariant.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: AppColors.calorieGradient,
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CalorieRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
