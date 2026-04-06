import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/profile/presentation/onboarding_flow.dart';
import '../../features/dashboard/presentation/home_screen.dart';
import '../../features/meal_log/presentation/meal_log_screen.dart';
import '../../features/meal_log/presentation/photo_capture_screen.dart';
import '../../features/meal_log/presentation/manual_entry_screen.dart';
import '../../features/reports/presentation/weekly_report_screen.dart';
import '../../features/meal_plan/presentation/meal_plan_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../shared/widgets/app_scaffold.dart';

/// Route path constants.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String mealLog = '/meals';
  static const String photoCapture = '/meals/capture';
  static const String manualEntry = '/meals/manual';
  static const String reports = '/reports';
  static const String mealPlan = '/meal-plan';
  static const String profile = '/profile';
}

/// GoRouter provider for navigation.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      // ─── Auth Routes ───
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingFlow(),
      ),

      // ─── Main App (with bottom nav) ───
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.mealLog,
            name: 'mealLog',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MealLogScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.reports,
            name: 'reports',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WeeklyReportScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.mealPlan,
            name: 'mealPlan',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MealPlanScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),

      // ─── Full-screen Routes (no bottom nav) ───
      GoRoute(
        path: AppRoutes.photoCapture,
        name: 'photoCapture',
        builder: (context, state) => const PhotoCaptureScreen(),
      ),
      GoRoute(
        path: AppRoutes.manualEntry,
        name: 'manualEntry',
        builder: (context, state) => const ManualEntryScreen(),
      ),
    ],
  );
});
