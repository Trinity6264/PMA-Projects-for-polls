import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:imei_plugin/imei_plugin.dart';
import 'package:pma/local_services/firebase_services/firebase_auth.dart';
import 'package:pma/screens/wrapper/home/pages/load_screen.dart';
import 'package:pma/shared/inputDecor.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, this.toggle}) : super(key: key);
  final Function? toggle;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _displayName = '';
  String _emailadd = '';
  String _password = '';

  final FireAuth _auth = FireAuth.auth;
  bool isLoading = false;
  bool isSeen = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Color(0xFF000000),
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Text(
                        'ADMIN PANEL',
                        style: GoogleFonts.alike(
                          color: Color(0xFFFF8F00),
                          fontSize: 30.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.0),
                          TextFormField(
                            onChanged: ((val) =>
                                setState(() => _displayName = val)),
                            validator: (val) =>
                                val!.isEmpty ? 'Name must be provided' : null,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Nickname',
                              hintStyle: GoogleFonts.aldrich(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          TextFormField(
                            onChanged: ((val) =>
                                setState(() => _emailadd = val)),
                            validator: (val) =>
                                val!.isEmpty ? 'Email must be provided' : null,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Email',
                              hintStyle: GoogleFonts.aldrich(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          TextFormField(
                            obscureText: isSeen,
                            onChanged: ((val) =>
                                setState(() => _password = val)),
                            validator: (val) => val!.isEmpty
                                ? 'Password must be provided'
                                : null,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: inputDecoration.copyWith(
                              suffixIcon: isSeen
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isSeen = false;
                                        });
                                      },
                                      icon: Icon(Icons.remove_red_eye,
                                          color: Colors.amber),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isSeen = true;
                                        });
                                      },
                                      icon: Icon(Icons.remove_red_eye_rounded,
                                          color: Colors.amber),
                                    ),
                              hintText: 'Password',
                              hintStyle: GoogleFonts.aldrich(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _size.height * 0.1 / 2,
                          ),
                          Container(
                            width: isLoading == true ? 40 : double.infinity,
                            child: isLoading == true
                                ? SpinKitPouringHourglass(color: Colors.amber)
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                                const Radius.circular(30),
                                            topRight:
                                                const Radius.circular(30)),
                                      ),
                                    ),
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.aldrich(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        dynamic user =
                                            await _auth.creatingNewUser(
                                          name: _displayName,
                                          email: _emailadd,
                                          password: _password,
                                        );
                                        if (user == null) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                    },
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: 'Already have an account? '),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.toggle!();
                                      },
                                    text: 'Sign In',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            _auth.errorMess,
                            style: GoogleFonts.aldrich(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
