import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';

/// Profile screen displaying user info, settings, and stats.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Settings
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.pagePaddingH),
        child: Column(
          children: [
            // Avatar & Name
            const CircleAvatar(
              radius: AppSizes.avatarLg / 2,
              backgroundColor: AppColors.primaryContainer,
              child: Icon(
                Icons.person_rounded,
                size: 36,
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: AppSizes.s12),
            Text(
              'Jane Doe',
              style: AppTypography.headlineMedium.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              'jane@example.com',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
            const SizedBox(height: AppSizes.s32),

            // Stats row
            Row(
              children: [
                _buildStatCard('Level', '8', Icons.star_rounded, AppColors.secondary),
                const SizedBox(width: AppSizes.s12),
                _buildStatCard('Streak', '12', Icons.local_fire_department_rounded, AppColors.calories),
                const SizedBox(width: AppSizes.s12),
                _buildStatCard('XP', '2.4K', Icons.bolt_rounded, AppColors.primary),
              ],
            ),
            const SizedBox(height: AppSizes.s24),

            // Settings list
            _buildMenuItem(Icons.person_outlined, 'Edit Profile'),
            _buildMenuItem(Icons.track_changes_outlined, 'Nutrition Targets'),
            _buildMenuItem(Icons.restaurant_outlined, 'Dietary Preferences'),
            _buildMenuItem(Icons.notifications_outlined, 'Notifications'),
            _buildMenuItem(Icons.palette_outlined, 'Appearance'),
            _buildMenuItem(Icons.download_outlined, 'Export Data'),
            _buildMenuItem(Icons.help_outline_rounded, 'Help & Support'),
            const Divider(height: AppSizes.s32),
            _buildMenuItem(
              Icons.logout_rounded,
              'Sign Out',
              color: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.s16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: AppSizes.s4),
            Text(
              value,
              style: AppTypography.headlineMedium.copyWith(color: color),
            ),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: color.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {Color? color}) {
    final itemColor = color ?? AppColors.darkTextPrimary;
    return ListTile(
      leading: Icon(icon, color: itemColor, size: 22),
      title: Text(
        label,
        style: AppTypography.bodyLarge.copyWith(color: itemColor),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: AppColors.darkTextTertiary,
        size: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.s4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      onTap: () {
        // TODO: Navigate to detail screen
      },
    );
  }
}
