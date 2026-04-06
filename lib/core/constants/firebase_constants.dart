/// Firestore collection names and storage path templates.
class FirebaseConstants {
  FirebaseConstants._();

  // ─── Firestore Collections ──────────────────────────────────
  static const String usersCollection = 'users';
  static const String mealsSubcollection = 'meals';
  static const String dailySummariesSubcollection = 'dailySummaries';
  static const String weeklySummariesSubcollection = 'weeklySummaries';
  static const String mealPlansSubcollection = 'mealPlans';
  static const String weightEntriesSubcollection = 'weightEntries';

  // ─── Storage Paths ───────────────────────────────────────────
  static String userMealPhotoPath(String uid, String filename) =>
      'users/$uid/meals/$filename';

  static String userAvatarPath(String uid) =>
      'users/$uid/avatar.jpg';

  // ─── Cloud Functions Endpoints ───────────────────────────────
  static const String generateMealPlanFunction = 'generateMealPlan';
  static const String recalculateTargetsFunction = 'recalculateTargets';
}
