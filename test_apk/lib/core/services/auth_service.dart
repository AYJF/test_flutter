import '../models/models.dart';

abstract class AuthService {
  AuthUserModel? currentUser();

  Stream<AuthUserModel?> get onAuthChanged;

  Future<AuthUserModel?> signInWithEmailAndPassword(
      {String? email, String? password});

  // Future<AuthUserModel?> signInWithGoogle();

  Future<void> signOut();

  // Future<void> sendPasswordResetEmail(String email);

  // Future<dynamic> registerWithEmailAndPass(String? email, String? password);
  // Future<AuthUserModel?> signInWithFacebook();

  void dispose();
}
