import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LocalStore with ChangeNotifier {
  LocalStore._();
  static final LocalStore store = LocalStore._();
  String _errorMess = '';
  String get errorMess => _errorMess;
  Future addContestant({
    required String? fullname,
    required String? age,
    required String? school,
    required String? form,
    required String? displayPic,
  }) async {
    try {
      final CollectionReference _ref =
          FirebaseFirestore.instance.collection('Contestant');
      return await _ref.add({
        'profile': displayPic,
        'fullname': fullname,
        'age': age,
        'school': school,
        'form': form,
        'votes': 0,
      });
    } on FirebaseException catch (e) {
      _errorMess = e.message!;
      notifyListeners();
    }
  }
}
