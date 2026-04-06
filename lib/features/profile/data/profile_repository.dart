import '../domain/user_profile.dart';

/// Profile repository — manages user profile data in Firestore.
class ProfileRepository {
  ProfileRepository();

  /// Save user profile to Firestore.
  Future<void> saveProfile(String uid, UserProfile profile) async {
    // await _firestore.collection('users').doc(uid).update({
    //   'profile': profile.toMap(),
    //   'updatedAt': FieldValue.serverTimestamp(),
    // });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Save computed nutrition targets.
  Future<void> saveTargets(
    String uid,
    Map<String, int> targets,
  ) async {
    // await _firestore.collection('users').doc(uid).update({
    //   'targets': targets,
    //   'updatedAt': FieldValue.serverTimestamp(),
    // });
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Mark onboarding as complete.
  Future<void> completeOnboarding(String uid) async {
    // await _firestore.collection('users').doc(uid).update({
    //   'hasCompletedOnboarding': true,
    //   'updatedAt': FieldValue.serverTimestamp(),
    // });
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Get user profile.
  Future<UserProfile?> getProfile(String uid) async {
    // final doc = await _firestore.collection('users').doc(uid).get();
    // if (!doc.exists) return null;
    // return UserProfile.fromMap(doc.data()!['profile']);
    return null;
  }
}
