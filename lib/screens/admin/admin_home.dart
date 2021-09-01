import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pma/screens/admin/new_contest.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.signOutAlt),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(),
        child: Icon(FontAwesomeIcons.female),
        tooltip: 'Add Contestant',
      ),
    );
  }
}
