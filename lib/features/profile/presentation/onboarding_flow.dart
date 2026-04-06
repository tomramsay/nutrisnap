import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/nutrition_calculator.dart';
import '../domain/user_profile.dart';

/// Multi-step onboarding wizard.
///
/// Steps:
/// 1. Personal info (sex, date of birth)
/// 2. Body measurements (height, weight)
/// 3. Goal selection (lose/maintain/gain) + activity level
/// 4. Dietary preferences + allergies
class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  static const int _totalSteps = 4;

  // Step 1: Personal
  String _sex = 'female';
  DateTime _dateOfBirth = DateTime(1995, 1, 1);

  // Step 2: Body
  final _heightController = TextEditingController(text: '170');
  final _weightController = TextEditingController(text: '70');
  final _goalWeightController = TextEditingController();

  // Step 3: Goals
  String _goalType = 'maintain';
  String _activityLevel = 'moderate';

  // Step 4: Diet
  String _dietaryPreference = 'omnivore';
  final List<String> _allergies = [];

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _completeOnboarding() {
    // Build profile and calculate targets
    final profile = UserProfile(
      dateOfBirth: _dateOfBirth.toIso8601String().split('T').first,
      sex: _sex,
      heightCm: double.tryParse(_heightController.text) ?? 170,
      currentWeightKg: double.tryParse(_weightController.text) ?? 70,
      goalWeightKg: double.tryParse(_goalWeightController.text),
      activityLevel: _activityLevel,
      dietaryPreference: _dietaryPreference,
      allergies: _allergies,
      goalType: _goalType,
    );

    // Calculate nutrition targets
    final age = NutritionCalculator.calculateAge(_dateOfBirth);
    final bmr = NutritionCalculator.calculateBMR(
      weightKg: profile.currentWeightKg,
      heightCm: profile.heightCm,
      age: age,
      isMale: _sex == 'male',
    );
    final tdee = NutritionCalculator.calculateTDEE(
      bmr: bmr,
      activityLevel: _activityLevel,
    );
    final calories = NutritionCalculator.calculateCalorieTarget(
      tdee: tdee,
      goalType: _goalType,
    );
    final macros = NutritionCalculator.calculateMacroTargets(
      calories: calories,
    );

    // TODO: Save profile + targets to Firestore
    debugPrint('Profile: ${profile.toMap()}');
    debugPrint('Calories: $calories, Macros: $macros');

    context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _goalWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D3B36), AppColors.darkBackground],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress bar
              Padding(
                padding: const EdgeInsets.all(AppSizes.pagePaddingH),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentStep > 0)
                          IconButton(
                            onPressed: _prevStep,
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                          )
                        else
                          const SizedBox(width: 48),
                        Text(
                          'Step ${_currentStep + 1} of $_totalSteps',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.darkTextSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(AppRoutes.home),
                          child: Text(
                            'Skip',
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.darkTextTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.s12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                      child: LinearProgressIndicator(
                        value: (_currentStep + 1) / _totalSteps,
                        backgroundColor: AppColors.darkSurfaceVariant,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),

              // Page content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildPersonalStep(),
                    _buildBodyStep(),
                    _buildGoalStep(),
                    _buildDietStep(),
                  ],
                ),
              ),

              // Next button
              Padding(
                padding: const EdgeInsets.all(AppSizes.pagePaddingH),
                child: ElevatedButton(
                  onPressed: _nextStep,
                  child: Text(
                    _currentStep == _totalSteps - 1
                        ? 'Get Started'
                        : 'Continue',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══ Step 1: Personal Info ═══
  Widget _buildPersonalStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.s32),
          Text(
            'About You',
            style: AppTypography.displaySmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s8),
          Text(
            'Help us personalise your nutrition targets',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.s40),

          // Sex selection
          Text(
            'I am',
            style: AppTypography.titleMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s12),
          Row(
            children: [
              _buildOptionChip('Male', 'male', _sex, (v) {
                setState(() => _sex = v);
              }),
              const SizedBox(width: AppSizes.s12),
              _buildOptionChip('Female', 'female', _sex, (v) {
                setState(() => _sex = v);
              }),
            ],
          ),
          const SizedBox(height: AppSizes.s32),

          // Date of birth
          Text(
            'Date of Birth',
            style: AppTypography.titleMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s12),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _dateOfBirth,
                firstDate: DateTime(1920),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() => _dateOfBirth = picked);
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.s16),
              decoration: BoxDecoration(
                color: AppColors.darkSurfaceVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                border: Border.all(
                  color: AppColors.darkSurfaceVariant,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.darkTextSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: AppSizes.s12),
                  Text(
                    '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}',
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white,
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

  // ═══ Step 2: Body Measurements ═══
  Widget _buildBodyStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.s32),
          Text(
            'Your Body',
            style: AppTypography.displaySmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s8),
          Text(
            'We use this to calculate your nutrition needs',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.s40),

          TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Height (cm)',
              prefixIcon: Icon(Icons.height_rounded),
              suffixText: 'cm',
            ),
          ),
          const SizedBox(height: AppSizes.s16),

          TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Current weight (kg)',
              prefixIcon: Icon(Icons.monitor_weight_outlined),
              suffixText: 'kg',
            ),
          ),
          const SizedBox(height: AppSizes.s16),

          TextFormField(
            controller: _goalWeightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Goal weight (optional)',
              prefixIcon: Icon(Icons.flag_outlined),
              suffixText: 'kg',
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Step 3: Goal & Activity ═══
  Widget _buildGoalStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.s32),
          Text(
            'Your Goal',
            style: AppTypography.displaySmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s8),
          Text(
            'What would you like to achieve?',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.s32),

          _buildGoalCard(
            'Lose Weight',
            'Reduce body fat with a calorie deficit',
            Icons.trending_down_rounded,
            'lose',
          ),
          const SizedBox(height: AppSizes.s12),
          _buildGoalCard(
            'Maintain',
            'Stay at your current weight',
            Icons.balance_rounded,
            'maintain',
          ),
          const SizedBox(height: AppSizes.s12),
          _buildGoalCard(
            'Gain Weight',
            'Build muscle with a calorie surplus',
            Icons.trending_up_rounded,
            'gain',
          ),

          const SizedBox(height: AppSizes.s32),
          Text(
            'Activity Level',
            style: AppTypography.titleMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s12),

          ..._buildActivityOptions(),
        ],
      ),
    );
  }

  List<Widget> _buildActivityOptions() {
    final options = [
      ('Sedentary', 'Little to no exercise', 'sedentary'),
      ('Light', 'Exercise 1–3 days/week', 'light'),
      ('Moderate', 'Exercise 3–5 days/week', 'moderate'),
      ('Active', 'Exercise 6–7 days/week', 'active'),
      ('Very Active', 'Intense exercise daily', 'very_active'),
    ];

    return options.map((opt) {
      final isSelected = _activityLevel == opt.$3;
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.s8),
        child: GestureDetector(
          onTap: () => setState(() => _activityLevel = opt.$3),
          child: Container(
            padding: const EdgeInsets.all(AppSizes.s12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryContainer.withValues(alpha: 0.5)
                  : AppColors.darkSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.darkSurfaceVariant,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        opt.$1,
                        style: AppTypography.titleSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        opt.$2,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  // ═══ Step 4: Dietary Preferences ═══
  Widget _buildDietStep() {
    final dietOptions = [
      'omnivore',
      'vegetarian',
      'vegan',
      'pescatarian',
      'keto',
      'paleo',
    ];
    final allergyOptions = [
      'Gluten',
      'Dairy',
      'Peanuts',
      'Tree Nuts',
      'Shellfish',
      'Soy',
      'Eggs',
      'Fish',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.s32),
          Text(
            'Dietary Preferences',
            style: AppTypography.displaySmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s8),
          Text(
            'We\'ll tailor meal plans to your needs',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.s32),

          Text(
            'Diet Type',
            style: AppTypography.titleMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s12),
          Wrap(
            spacing: AppSizes.s8,
            runSpacing: AppSizes.s8,
            children: dietOptions.map((diet) {
              return _buildOptionChip(
                diet[0].toUpperCase() + diet.substring(1),
                diet,
                _dietaryPreference,
                (v) => setState(() => _dietaryPreference = v),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSizes.s32),
          Text(
            'Allergies & Intolerances',
            style: AppTypography.titleMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.s4),
          Text(
            'Select any that apply',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.darkTextTertiary,
            ),
          ),
          const SizedBox(height: AppSizes.s12),
          Wrap(
            spacing: AppSizes.s8,
            runSpacing: AppSizes.s8,
            children: allergyOptions.map((allergy) {
              final isSelected = _allergies.contains(allergy.toLowerCase());
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _allergies.remove(allergy.toLowerCase());
                    } else {
                      _allergies.add(allergy.toLowerCase());
                    }
                  });
                },
                child: Chip(
                  label: Text(allergy),
                  backgroundColor: isSelected
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : AppColors.darkSurfaceVariant.withValues(alpha: 0.5),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.darkSurfaceVariant,
                  ),
                  avatar: isSelected
                      ? const Icon(Icons.check, size: 16, color: AppColors.primary)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── Helper Widgets ───

  Widget _buildOptionChip(
    String label,
    String value,
    String selected,
    ValueChanged<String> onSelected,
  ) {
    final isSelected = value == selected;
    return GestureDetector(
      onTap: () => onSelected(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s20,
          vertical: AppSizes.s12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.2)
              : AppColors.darkSurfaceVariant.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppSizes.radiusXxl),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.darkSurfaceVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: isSelected ? AppColors.primary : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(
    String title,
    String subtitle,
    IconData icon,
    String value,
  ) {
    final isSelected = _goalType == value;
    return GestureDetector(
      onTap: () => setState(() => _goalType = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSizes.s16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer.withValues(alpha: 0.4)
              : AppColors.darkSurfaceVariant.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.darkSurfaceVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : AppColors.darkSurfaceVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.darkTextSecondary,
              ),
            ),
            const SizedBox(width: AppSizes.s16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
