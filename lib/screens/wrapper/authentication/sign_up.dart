import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:pma/local_services/firebase_services/firebase_auth.dart';
import 'package:pma/screens/wrapper/home/pages/load_screen.dart';
import 'package:pma/shared/inputDecor.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, this.toggle}) : super(key: key);
  final Function? toggle;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _displayName = '';
  String _email = '';
  String _password = '';
  String error = '';
  bool isLoading = false;
  final _auth = FireAuth.auth;
  final _formKey = GlobalKey<FormState>();
  File? image;
  Future getImage() async {
    try {
      final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_image == null) return;
      setState(() {
        image = File(_image.path);
        print(image!.path);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  // imei var
  String imei = 'Unknown';

  Future imeiPlugin() async {
    String multiImei =
        await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    setState(() {
      imei = multiImei;
    });
  }

  @override
  void initState() {
    imeiPlugin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: isLoading == true
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Text(
                        'SIGN UP',
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
                            onChanged: ((val) =>
                                setState(() => _displayName = val)),
                            validator: (val) =>
                                val!.length < 3 ? 'User name is short' : null,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Username',
                              hintStyle: GoogleFonts.aldrich(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          TextFormField(
                            onChanged: ((val) => setState(() => _email = val)),
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                            onChanged: ((val) =>
                                setState(() => _password = val)),
                            validator: (val) => val!.length < 6
                                ? 'Password must be 6+ char'
                                : null,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.visiblePassword,
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
                            width: isLoading == true ? 40 : double.infinity,
                            child: isLoading == true
                                ? SpinKitPouringHourglass(color: Colors.amber)
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            topRight: Radius.circular(30)),
                                      ),
                                    ),
                                    child: Text(
                                      'CREATE MY ACCOUNT',
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
                                        dynamic result = _auth.creatingNewUser(
                                          name: _displayName,
                                          email: _email,
                                          password: _password,
                                        );
                                        print(result);
                                        if (result == null) {
                                          setState(() {
                                            error = _auth.error;
                                            isLoading = false;
                                          });
                                        }
                                        print(_displayName);
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'Already have an Account? '),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                widget.toggle!();
                              },
                            text: ' Sign In',
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
                        imei,
                        style: TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
