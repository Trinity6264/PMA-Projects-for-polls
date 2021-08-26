import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pma/shared/inputDecor.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, this.toggle}) : super(key: key);
  final Function? toggle;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
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
                            borderRadius: BorderRadius.circular(50),
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              // Text(
              //   'or login with',
              //   style: GoogleFonts.aldrich(
              //     color: Colors.white,
              //     fontSize: 20.0,
              //     fontStyle: FontStyle.italic,
              //     letterSpacing: 1.5,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 40.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       _authLogo('Google'),
              //       _authLogo('Facebook'),
              //       _authLogo('Twitter'),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Don\'t have an account? '),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('sign Up');
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
