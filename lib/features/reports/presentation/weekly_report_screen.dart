import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';

/// Weekly report screen with charts.
class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'week', label: Text('Week')),
              ButtonSegment(value: 'month', label: Text('Month')),
            ],
            selected: const {'week'},
            onSelectionChanged: (_) {},
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              textStyle: WidgetStateProperty.all(AppTypography.labelSmall),
            ),
          ),
          const SizedBox(width: AppSizes.s16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.pagePaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calorie trend placeholder
            _buildChartPlaceholder(
              context,
              'Calorie Trend',
              'This Week',
              Icons.show_chart_rounded,
              AppColors.calories,
            ),
            const SizedBox(height: AppSizes.s16),

            // Macro split placeholder
            _buildChartPlaceholder(
              context,
              'Macro Split',
              'Average',
              Icons.pie_chart_rounded,
              AppColors.protein,
            ),
            const SizedBox(height: AppSizes.s16),

            // AI Insight card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.s16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryContainer.withValues(alpha: 0.5),
                    AppColors.darkSurface,
                  ],
                ),
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSizes.s8),
                      Text(
                        'AI Weekly Insight',
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s12),
                  Text(
                    'You consistently hit your protein target this week — great job! '
                    'Consider adding more fibre-rich vegetables. '
                    'You averaged 20g vs your 25g goal.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.darkTextPrimary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.s80),
          ],
        ),
      ),
    );
  }

  Widget _buildChartPlaceholder(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(
          color: AppColors.darkSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.titleSmall.copyWith(color: Colors.white),
              ),
              Text(
                subtitle,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.darkTextTertiary,
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Icon(
                icon,
                size: 48,
                color: color.withValues(alpha: 0.3),
              ),
            ),
          ),
          Text(
            'Charts will render with fl_chart when data is available',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.darkTextTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
