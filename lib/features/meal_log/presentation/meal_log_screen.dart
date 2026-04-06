import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';

/// Meal log screen — chronological list of today's and past meals.
class MealLogScreen extends StatelessWidget {
  const MealLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Log'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu_rounded,
              size: 64,
              color: AppColors.darkTextTertiary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSizes.s16),
            Text(
              'Your meals will appear here',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
            const SizedBox(height: AppSizes.s8),
            Text(
              'Tap the camera button to log your first meal',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.darkTextTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
