import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pma/models/fire_store_user.dart';
import 'package:provider/provider.dart';

class HomeState extends StatefulWidget {
  const HomeState({Key? key}) : super(key: key);

  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  @override
  Widget build(BuildContext context) {
    final contestants = Provider.of<List<FireStoreUser>?>(context);
    if (contestants?.length == 0) {
      print('no Data');
    } else {
      print('Data Found');
      print(contestants?.length);
    }
    return Container();
  }
}
