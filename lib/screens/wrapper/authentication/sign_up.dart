import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  final FireAuth _auth = FireAuth.auth;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // imei var
  // String imei = 'Unknown';

  // Future imeiPlugin() async {
  //   String multiImei =
  //       await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
  //   setState(() {
  //     imei = multiImei;
  //   });
  // }

  @override
  void initState() {
    // imeiPlugin();
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
                        'PMA POLL APP',
                        maxLines: 1,
                        style: GoogleFonts.alike(
                          color: Color(0xFFFF8F00),
                          fontSize: 28.0,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: TextFormField(
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
                                hintText: 'Enter your name',
                                hintStyle: GoogleFonts.aldrich(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                ),
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
                                      'Let\'s Go',
                                      style: GoogleFonts.aldrich(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // setState(() {
                                        //   isLoading = true;
                                        // });
                                        // dynamic results =
                                        //     _auth.signInAnon(_displayName);
                                        // if (results == null) {
                                        //   setState(() {
                                        //     isLoading = false;
                                        //   });
                                        // }
                                      }
                                    },
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
