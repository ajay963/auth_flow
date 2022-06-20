import 'package:auth_flow/widgets/custom_snakbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  Authentication(this._firebaseAuth);
  User get user => _firebaseAuth.currentUser!;
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(
            context: context,
            text:
                'The password provided is too weak.'); // Displaying the usual firebase error message
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
            context: context,
            text: 'The account already exists for that email.');
      }
      showSnackBar(
          context: context,
          text: e.message
              .toString()); // Displaying the usual firebase error message
    }
  }

  Future<void> googleSignIn({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        //  storing information in firestore
        // only for new users using google sign in

        // if (userCredential.user != null) {
        //   if (userCredential.additionalUserInfo!.isNewUser) {}
        // }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, text: e.message.toString());
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      showSnackBar(context: context, text: e.message.toString());
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
