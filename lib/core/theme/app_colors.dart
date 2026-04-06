import 'package:flutter/material.dart';

/// NutriSnap colour palette.
///
/// Deep Teal primary (health/wellness) + Warm Amber accent (energy/nutrition).
/// Dark mode first design with carefully tuned surface hierarchy.
class AppColors {
  AppColors._();

  // ─── Brand Colours ───────────────────────────────────────────
  static const Color primary = Color(0xFF0D9488);        // Deep Teal
  static const Color primaryLight = Color(0xFF2DD4BF);   // Teal 400
  static const Color primaryDark = Color(0xFF0F766E);    // Teal 700
  static const Color primaryContainer = Color(0xFF134E4A); // Teal 900

  static const Color secondary = Color(0xFFF59E0B);      // Warm Amber
  static const Color secondaryLight = Color(0xFFFBBF24); // Amber 400
  static const Color secondaryDark = Color(0xFFD97706);  // Amber 600
  static const Color secondaryContainer = Color(0xFF78350F); // Amber 900

  // ─── Dark Theme Surfaces ─────────────────────────────────────
  static const Color darkBackground = Color(0xFF0F172A);    // Slate 900
  static const Color darkSurface = Color(0xFF1E293B);       // Slate 800
  static const Color darkSurfaceVariant = Color(0xFF334155); // Slate 700
  static const Color darkSurfaceHigh = Color(0xFF475569);   // Slate 600
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkBottomNav = Color(0xFF0F172A);

  // ─── Light Theme Surfaces ────────────────────────────────────
  static const Color lightBackground = Color(0xFFF8FAFC);   // Slate 50
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9); // Slate 100
  static const Color lightCard = Color(0xFFFFFFFF);

  // ─── Text Colours ────────────────────────────────────────────
  static const Color darkTextPrimary = Color(0xFFF8FAFC);   // Slate 50
  static const Color darkTextSecondary = Color(0xFF94A3B8);  // Slate 400
  static const Color darkTextTertiary = Color(0xFF64748B);   // Slate 500

  static const Color lightTextPrimary = Color(0xFF0F172A);   // Slate 900
  static const Color lightTextSecondary = Color(0xFF475569); // Slate 600
  static const Color lightTextTertiary = Color(0xFF94A3B8);  // Slate 400

  // ─── Semantic Colours ────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);        // Green 500
  static const Color successLight = Color(0xFF4ADE80);   // Green 400
  static const Color successDark = Color(0xFF166534);    // Green 800

  static const Color warning = Color(0xFFF59E0B);        // Amber 500
  static const Color warningLight = Color(0xFFFBBF24);   // Amber 400
  static const Color warningDark = Color(0xFF92400E);    // Amber 800

  static const Color error = Color(0xFFEF4444);          // Red 500
  static const Color errorLight = Color(0xFFF87171);     // Red 400
  static const Color errorDark = Color(0xFF991B1B);      // Red 800

  static const Color info = Color(0xFF3B82F6);           // Blue 500
  static const Color infoLight = Color(0xFF60A5FA);      // Blue 400
  static const Color infoDark = Color(0xFF1E3A8A);       // Blue 900

  // ─── Macro Nutrient Colours ──────────────────────────────────
  static const Color calories = Color(0xFFF59E0B);       // Amber
  static const Color protein = Color(0xFF3B82F6);        // Blue
  static const Color carbs = Color(0xFFF97316);          // Orange
  static const Color fat = Color(0xFFA855F7);            // Purple
  static const Color fibre = Color(0xFF22C55E);          // Green
  static const Color water = Color(0xFF06B6D4);          // Cyan

  // ─── Chart Gradient Colours ──────────────────────────────────
  static const List<Color> calorieGradient = [Color(0xFFF59E0B), Color(0xFFEF4444)];
  static const List<Color> proteinGradient = [Color(0xFF3B82F6), Color(0xFF8B5CF6)];
  static const List<Color> carbsGradient = [Color(0xFFF97316), Color(0xFFF59E0B)];
  static const List<Color> fatGradient = [Color(0xFFA855F7), Color(0xFFEC4899)];

  // ─── Misc ────────────────────────────────────────────────────
  static const Color divider = Color(0xFF334155);
  static const Color shimmerBase = Color(0xFF1E293B);
  static const Color shimmerHighlight = Color(0xFF334155);
  static const Color overlay = Color(0x80000000);
}
