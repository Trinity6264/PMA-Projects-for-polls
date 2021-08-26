import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pma/shared/colors.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5),
        () => Navigator.of(context).pushReplacementNamed('/wrapper'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF000000),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(
                    'PMA ENTERTAINMENT',
                    style: GoogleFonts.alike(
                      color: textClr,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Container(
                  child: Image(
                    image: AssetImage('images/pma.jpg'),
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.darken,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Spacer(),
                CircularProgressIndicator(),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
