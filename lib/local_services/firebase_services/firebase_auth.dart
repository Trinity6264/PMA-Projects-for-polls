import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pma/models/fire_user.dart';

class FireAuth with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FireAuth._();
  static final FireAuth auth = FireAuth._();

  // creating a custom user
  CustomUser? _userFromFirebase({required User? user}) {
    return user != null
        ? CustomUser(
            uid: user.uid,
            userName: user.displayName,
            userProfile: user.photoURL)
        : null;
  }

  // error getter
  String? _error = 'Please provide valid email';
  String get error => _error!;

  // Checking User Status
  Stream<CustomUser?> get userStatus {
    return _auth
        .authStateChanges()
        .map((User? event) => _userFromFirebase(user: event));
  }

  // Sign Up with your phone number
  Future signUpwithPhone(
      {required String number, required String userName}) async {
    try {
      // _auth.verifyPhoneNumber(
      // phoneNumber: number,
      // verificationCompleted: _verificationCompleted,
      // verificationFailed: null,
      // codeSent: null,
      // codeAutoRetrievalTimeout: null,
      // );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future _verificationCompleted(PhoneAuthCredential credential) async {
    try {} on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  // sign Up with Email And Password
  Future signOut() async {
    try {
      return _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
