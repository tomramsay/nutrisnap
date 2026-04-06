import 'dart:math';

/// Nutrition calculation utilities.
///
/// Implements Mifflin-St Jeor equation for BMR and TDEE,
/// plus macro target calculations.
class NutritionCalculator {
  NutritionCalculator._();

  /// Activity level multipliers for TDEE calculation.
  static const Map<String, double> activityMultipliers = {
    'sedentary': 1.2,
    'light': 1.375,
    'moderate': 1.55,
    'active': 1.725,
    'very_active': 1.9,
  };

  /// Calculate BMR using Mifflin-St Jeor equation.
  ///
  /// - [weightKg]: Current weight in kilograms
  /// - [heightCm]: Height in centimetres
  /// - [age]: Age in years
  /// - [isMale]: true for male, false for female
  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required bool isMale,
  }) {
    final double base = (10 * weightKg) + (6.25 * heightCm) - (5 * age);
    return isMale ? base + 5 : base - 161;
  }

  /// Calculate Total Daily Energy Expenditure (TDEE).
  static double calculateTDEE({
    required double bmr,
    required String activityLevel,
  }) {
    final multiplier = activityMultipliers[activityLevel] ?? 1.55;
    return bmr * multiplier;
  }

  /// Calculate daily calorie target based on goal.
  ///
  /// - lose: TDEE - 500 (aim ~0.5kg/week loss)
  /// - maintain: TDEE
  /// - gain: TDEE + 300 (lean gain)
  static int calculateCalorieTarget({
    required double tdee,
    required String goalType,
  }) {
    switch (goalType) {
      case 'lose':
        return max((tdee - 500).round(), 1200); // Never below 1200
      case 'gain':
        return (tdee + 300).round();
      case 'maintain':
      default:
        return tdee.round();
    }
  }

  /// Calculate macro targets from calorie target.
  ///
  /// Default split: 30% protein, 40% carbs, 30% fat.
  /// Fitness users get: 35% protein, 40% carbs, 25% fat.
  static Map<String, int> calculateMacroTargets({
    required int calories,
    bool isFitnessUser = false,
  }) {
    final double proteinRatio = isFitnessUser ? 0.35 : 0.30;
    final double carbsRatio = 0.40;
    final double fatRatio = isFitnessUser ? 0.25 : 0.30;

    return {
      'proteinG': (calories * proteinRatio / 4).round(), // 4 cal/g
      'carbsG': (calories * carbsRatio / 4).round(),     // 4 cal/g
      'fatG': (calories * fatRatio / 9).round(),         // 9 cal/g
      'fibreG': 25, // Default recommendation
    };
  }

  /// Calculate age from date of birth.
  static int calculateAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  /// Calculate BMI.
  static double calculateBMI({
    required double weightKg,
    required double heightCm,
  }) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Get BMI category string.
  static String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}
