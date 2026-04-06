import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';

/// Full-screen camera capture for meal photos.
class PhotoCaptureScreen extends StatelessWidget {
  const PhotoCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Capture Meal'),
      ),
      body: Stack(
        children: [
          // Camera preview placeholder
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.darkBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_rounded,
                    size: 80,
                    color: AppColors.darkTextTertiary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: AppSizes.s16),
                  Text(
                    'Camera preview will appear here',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.s8),
                  Text(
                    'Centre your plate in the frame',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.darkTextTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s32,
                vertical: AppSizes.s24,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Gallery
                  IconButton(
                    onPressed: () {
                      // TODO: Open gallery picker
                    },
                    icon: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  // Capture button
                  GestureDetector(
                    onTap: () {
                      // TODO: Capture photo
                    },
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Manual entry
                  IconButton(
                    onPressed: () {
                      // TODO: Navigate to manual entry
                    },
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
