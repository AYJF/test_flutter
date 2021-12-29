import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_flutter/models/users.dart';
import '../services/database_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Users? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return Users(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      // photoUrl: user.photoUrl,
    );
  }

  Stream<Users?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((user) {
      return _userFromFirebase(user);
    });
  }

  Future<Users?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<Users?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    assert(email != null && password != null);

    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return _userFromFirebase(userCredential.user);
  }

  Future<Users?> registerUser({
    String? email,
    String? password,
    String? name,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    final model = {
      'email': email,
      'name': name,
    };

    await DataService(uid: userCredential.user!.uid).updateUserData(model);

    return _userFromFirebase(userCredential.user);
  }

  Future<Users?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);

    final model = {
      'email': authResult.user!.email,
      'name': authResult.user!.displayName,
    };

    await DataService(uid: authResult.user!.uid).updateUserData(model);

    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<Users?> currentUser() async {
    final User? user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }
}
