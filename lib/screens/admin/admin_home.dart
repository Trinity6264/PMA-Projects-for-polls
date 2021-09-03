import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pma/local_services/firebase_services/firebase_auth.dart';
import 'package:pma/local_services/firebase_services/firebase_store.dart';
import 'package:pma/models/fire_store_user.dart';
import 'package:pma/screens/admin/home_state.dart';
import 'package:pma/screens/admin/new_contest.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);
  static final FireAuth _auth = FireAuth.auth;

  @override
  Widget build(BuildContext context) {
    void _showBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (_) => Contestant(),
      );
    }

    return StreamProvider<List<FireStoreUser>?>.value(
      initialData: [],
      catchError: (_, __) => null,
      value: LocalStore.store.contestant,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin'),
          actions: [
            IconButton(
              onPressed: () async {
                _auth.signOut();
              },
              icon: Icon(FontAwesomeIcons.signOutAlt),
            ),
          ],
        ),
        body: HomeState(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showBottomSheet(),
          child: Icon(FontAwesomeIcons.female),
          tooltip: 'Add Contestant',
        ),
      ),
    );
  }
}
