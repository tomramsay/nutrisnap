import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';

/// Meal plan screen showing weekly AI-generated plans.
class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plan'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to grocery list
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.s32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.secondary.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
              const SizedBox(height: AppSizes.s24),
              Text(
                'AI Meal Planning',
                style: AppTypography.headlineMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSizes.s12),
              Text(
                'Generate a personalised weekly meal plan\npowered by Gemini AI, tailored to your\ngoals and preferences.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.darkTextSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.s32),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Generate meal plan
                },
                icon: const Icon(Icons.auto_awesome_rounded),
                label: const Text('Generate Meal Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
