/// Auth repository — abstracts Firebase Auth operations.
///
/// TODO: Uncomment Firebase calls once Firebase is configured.
class AuthRepository {
  // final FirebaseAuth _auth;
  // final FirebaseFirestore _firestore;

  // AuthRepository(this._auth, this._firestore);
  AuthRepository();

  /// Sign in with email and password.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    // await _auth.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    // Simulated delay for UI testing
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Create a new account with email and password.
  Future<void> createAccountWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    // final credential = await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );
    // await credential.user?.updateDisplayName(displayName);
    //
    // // Create user document in Firestore
    // await _firestore.collection('users').doc(credential.user!.uid).set({
    //   'email': email,
    //   'displayName': displayName,
    //   'createdAt': FieldValue.serverTimestamp(),
    //   'updatedAt': FieldValue.serverTimestamp(),
    //   'hasCompletedOnboarding': false,
    // });

    await Future.delayed(const Duration(seconds: 1));
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    // final googleUser = await GoogleSignIn().signIn();
    // final googleAuth = await googleUser?.authentication;
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
    // await _auth.signInWithCredential(credential);

    await Future.delayed(const Duration(seconds: 1));
  }

  /// Sign out.
  Future<void> signOut() async {
    // await _auth.signOut();
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Send password reset email.
  Future<void> sendPasswordResetEmail(String email) async {
    // await _auth.sendPasswordResetEmail(email: email);
    await Future.delayed(const Duration(seconds: 1));
  }
}
