import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pma/images_list.dart';
import 'package:pma/local_services/firebase_services/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FireAuth.auth;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),
        elevation: 0.0,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.amber,
          ),
          TextButton(
            onPressed: () async {
              return await _auth.signOut();
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
      backgroundColor: Color(0xFF000000),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CarouselSlider(
            //   items: imageList
            //       .map((e) => Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Container(
            //                 decoration: BoxDecoration(
            //                   color: Colors.amber,
            //                   image: DecorationImage(
            //                     image: AssetImage(e.imagePath),
            //                     fit: BoxFit.fill,
            //                   ),
            //                 ),
            //                 padding: EdgeInsets.symmetric(horizontal: 50),
            //                 width: double.infinity,
            //                 child: Positioned(
            //                     child: Text(e.name,
            //                         style: TextStyle(color: Colors.white)))),
            //           ))
            //       .toList(),
            //   options: CarouselOptions(
            //     autoPlay: true,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
