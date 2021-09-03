import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pma/models/fire_store_user.dart';

class LocalStore with ChangeNotifier {
  LocalStore._();
  static final LocalStore store = LocalStore._();
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('Contestant');
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

  List<FireStoreUser>? _listContestant({QuerySnapshot? snapshot}) {
    return snapshot!.docs.isEmpty
        ? null
        : snapshot.docs
            .map(
              (e) => FireStoreUser(
                fullName: e['fullname'],
                age: e['age'],
                school: e['school'],
                form: e['form'],
                userpic: e['userpic'],
              ),
            )
            .toList();
  }

  Stream<List<FireStoreUser>?> get contestant {
    return _ref.snapshots().map((event) => _listContestant(snapshot: event));
  }
}
