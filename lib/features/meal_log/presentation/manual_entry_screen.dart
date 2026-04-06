import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';

/// Manual food entry screen.
class ManualEntryScreen extends StatelessWidget {
  const ManualEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.pagePaddingH),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search foods...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  onPressed: () {
                    // TODO: Barcode scanner
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.s24),

            // Recent foods placeholder
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: 48,
                      color: AppColors.darkTextTertiary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: AppSizes.s12),
                    Text(
                      'Search for foods to add',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSizes.s4),
                    Text(
                      'or scan a barcode',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.darkTextTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
