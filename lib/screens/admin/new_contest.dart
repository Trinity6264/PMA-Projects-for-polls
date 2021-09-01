import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pma/shared/contestDecoor.dart';

class Contestant extends StatefulWidget {
  const Contestant({Key? key}) : super(key: key);

  @override
  _ContestantState createState() => _ContestantState();
}

class _ContestantState extends State<Contestant> {
  XFile? image;
  Future getImage() async {
    var _imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = _imagePicker;
    });
    print('The path is: ${_imagePicker!.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 15),
                child: Text(
                  'Contestant Pov',
                  style: GoogleFonts.aclonica(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.amber,
                    child: ClipOval(
                      child: SizedBox(
                        height: 195,
                        width: 195,
                        child: image != null
                            ? Image.file(image as File, fit: BoxFit.cover)
                            : Icon(FontAwesomeIcons.camera),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: contestDecor.copyWith(
                          hintText: 'Fullname',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: contestDecor.copyWith(
                          hintText: 'Age',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: contestDecor.copyWith(
                          hintText: 'School',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: contestDecor.copyWith(
                          hintText: 'Form/Class',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                            ),
                          ),
                          onPressed: () {
                            print('submit');
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
