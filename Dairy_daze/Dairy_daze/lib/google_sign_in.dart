import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dairy_daze/Page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:dairy_daze/Page1.dart';
class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future googleSignOut() async {
    await googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> saveUserData(String userEnter) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      if (userId != null) {
        final userData = {
          'name': userEnter,
          'email': user?.email,
        };

        // Save user details to Firebase Realtime Database
        final reference = FirebaseDatabase.instance.reference();
        await reference.child('users').child(userId).set(userData);
      }
    } catch (e) {
      // Handle any errors that occur during the saving process
      print('Error saving user data: $e');
    }
  }
}
