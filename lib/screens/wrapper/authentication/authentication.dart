import 'package:flutter/material.dart';
import 'package:pma/screens/wrapper/authentication/sign_in.dart';
import 'package:pma/screens/wrapper/authentication/sign_up.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool toggle = false;
  void toggleView() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return toggle ? SignIn(toggle: toggleView) : SignUp(toggle: toggleView);
  }
}
