import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pma/local_services/firebase_services/firebase_auth.dart';
import 'package:pma/screens/wrapper/home/pages/load_screen.dart';
import 'package:pma/shared/inputDecor.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, this.toggle}) : super(key: key);
  final Function? toggle;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final _auth = FireAuth.auth;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String error = '';
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
                      padding: const EdgeInsets.all(60.0),
                      child: Text(
                        'SIGN IN',
                        style: GoogleFonts.alike(
                          color: Color(0xFFFF8F00),
                          fontSize: 40.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            onChanged: ((val) => setState(() => _email = val)),
                            validator: (val) =>
                                val!.isEmpty ? 'Provide email' : null,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
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
                            onChanged: ((val) =>
                                setState(() => _password = val)),
                            validator: (val) =>
                                val!.isEmpty ? 'Provide password' : null,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                            decoration: inputDecoration.copyWith(
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.amber,
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
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                ),
                              ),
                              child: Text(
                                'SIGN IN',
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
                                      await _auth.signInWithEmailAndPassword(
                                    _email,
                                    _password,
                                  );
                                  if (user == null) {
                                    setState(() {
                                      error = _auth.errorMess;
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Don\'t have an account? '),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                widget.toggle!();
                              },
                            text: ' Sign Up',
                            style: GoogleFonts.aldrich(
                              color: Colors.amber,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Center(
                      child: Text(
                        _auth.errorMess,
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
