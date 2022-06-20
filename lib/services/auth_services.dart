import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth_flow/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  UserData? _userFromFirebase(auth.User? user) {
    if (user == null) return null;
    return UserData(uid: user.uid, email: user.email!);
  }

  Stream<UserData?>? get user {
    return _firebaseAuth.authStateChanges().map((_userFromFirebase));
  }

  Future<void> signIn({required String email, required String password}) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserData?> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signInSilently();
    return _googleSignIn.onCurrentUserChanged.map((_userFromFirebase));
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on auth.FirebaseException catch (e) {
    } catch (e) {}
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
