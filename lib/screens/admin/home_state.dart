import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pma/local_services/firebase_services/firebase_store.dart';
import 'package:provider/provider.dart';

class HomeState extends StatefulWidget {
  const HomeState({Key? key}) : super(key: key);

  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  final _firestore = LocalStore.store;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuerySnapshot?>(context);
    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: LocalStore.store.getContestant,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: data?.docs.length == 0
            ? Center(
                child: Text(
                  'No Data Found',
                  style: GoogleFonts.aldrich(
                    fontSize: 20,
                  ),
                ),
              )
            : data?.docs.length == null
                ? Center(child: SpinKitRipple(size: 50, color: Colors.blue))
                : ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: data?.docs.length,
                    itemBuilder: (_, index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: Icon(FontAwesomeIcons.trash),
                        ),
                        onDismissed: (val) async {
                          await _firestore.deleteData(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${data?.docs[index]['fullname']} Deleted'),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.blue,
                          elevation: 10,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: Hero(
                            tag:
                                'image-location${data?.docs[index]['profile']}',
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                maxRadius: 30,
                                child: CircleAvatar(
                                  maxRadius: 27,
                                  backgroundImage: NetworkImage(
                                      data?.docs[index]['profile']),
                                ),
                              ),
                              title: Text(data?.docs[index]['fullname']),
                              trailing: Text("${data?.docs[index]['votes']}"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
