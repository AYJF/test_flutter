import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import '../models/models.dart';

/// Thrown during the login process if a failure occurs.
class SingInFailure implements Exception {}

/// Thrown if during the sign up process if a failure occurs.
class RegisterFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  AuthUserModel? _getUserModel(User? user) {
    return user?.toUserModel;
  }

  @override
  AuthUserModel? currentUser() {
    return _getUserModel(_firebaseAuth.currentUser);
  }

  @override
  Stream<AuthUserModel?> get onAuthChanged {
    return _firebaseAuth.userChanges().map((user) {
      return _getUserModel(user);
    });
  }

  @override
  Future<AuthUserModel?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    assert(email != null && password != null);
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return _getUserModel(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    // await _firebaseAuth.signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {}
}

extension on User {
  AuthUserModel get toUserModel {
    return AuthUserModel(
      id: uid,
      email: email ?? '',
      name: displayName ?? '',
      photo: photoURL ?? '',
    );
  }
}
