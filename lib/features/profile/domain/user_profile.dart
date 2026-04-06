/// Represents the user's profile and nutrition settings.
///
/// Stores personal data, dietary preferences, and calculated targets.
class UserProfile {
  final String? dateOfBirth;
  final String sex;
  final double heightCm;
  final double currentWeightKg;
  final double? goalWeightKg;
  final String activityLevel;
  final String dietaryPreference;
  final List<String> allergies;
  final String goalType;
  final String? fitnessGoal;

  const UserProfile({
    this.dateOfBirth,
    this.sex = 'female',
    this.heightCm = 170,
    this.currentWeightKg = 70,
    this.goalWeightKg,
    this.activityLevel = 'moderate',
    this.dietaryPreference = 'omnivore',
    this.allergies = const [],
    this.goalType = 'maintain',
    this.fitnessGoal,
  });

  UserProfile copyWith({
    String? dateOfBirth,
    String? sex,
    double? heightCm,
    double? currentWeightKg,
    double? goalWeightKg,
    String? activityLevel,
    String? dietaryPreference,
    List<String>? allergies,
    String? goalType,
    String? fitnessGoal,
  }) {
    return UserProfile(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      heightCm: heightCm ?? this.heightCm,
      currentWeightKg: currentWeightKg ?? this.currentWeightKg,
      goalWeightKg: goalWeightKg ?? this.goalWeightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      dietaryPreference: dietaryPreference ?? this.dietaryPreference,
      allergies: allergies ?? this.allergies,
      goalType: goalType ?? this.goalType,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateOfBirth': dateOfBirth,
      'sex': sex,
      'heightCm': heightCm,
      'currentWeightKg': currentWeightKg,
      'goalWeightKg': goalWeightKg,
      'activityLevel': activityLevel,
      'dietaryPreference': dietaryPreference,
      'allergies': allergies,
      'goalType': goalType,
      'fitnessGoal': fitnessGoal,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      dateOfBirth: map['dateOfBirth'] as String?,
      sex: map['sex'] as String? ?? 'female',
      heightCm: (map['heightCm'] as num?)?.toDouble() ?? 170,
      currentWeightKg: (map['currentWeightKg'] as num?)?.toDouble() ?? 70,
      goalWeightKg: (map['goalWeightKg'] as num?)?.toDouble(),
      activityLevel: map['activityLevel'] as String? ?? 'moderate',
      dietaryPreference: map['dietaryPreference'] as String? ?? 'omnivore',
      allergies: List<String>.from(map['allergies'] ?? []),
      goalType: map['goalType'] as String? ?? 'maintain',
      fitnessGoal: map['fitnessGoal'] as String?,
    );
  }
}
