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
  String _error = '';
  String get errorMess => _error;

  // Checking User Status
  Stream<CustomUser?> get userStatus {
    return _auth
        .authStateChanges()
        .map((User? event) => _userFromFirebase(user: event));
  }

  // Create new account
  Future creatingNewUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? _user = user.user;
      _user!.updateDisplayName(name);
      return _userFromFirebase(user: _user);
    } on FirebaseAuthException catch (e) {
      _error = e.message!;
      notifyListeners();
      return null;
    }
  }

  // Sign in

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userR = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? _user = userR.user;
      return _userFromFirebase(user: _user);
    } on FirebaseAuthException catch (e) {
      _error = e.message!;
      notifyListeners();
    }
  }

  // sign Out
  Future signOut() async {
    try {
      return _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
