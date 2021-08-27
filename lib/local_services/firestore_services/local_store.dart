import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LocalStore {
  String? uid = '';
  LocalStore({this.uid});

  // creating user obj and adding it to firestore

  Future updateUser(String name, String? imei) async {
    try {
      final CollectionReference _collections =
          FirebaseFirestore.instance.collection('voters');
      return await _collections.doc(uid).set({
        'name': name,
        'imei': imei,
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
