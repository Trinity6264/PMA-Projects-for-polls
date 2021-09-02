import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pma/local_services/firebase_services/firebase_store.dart';
import 'package:pma/shared/contestDecoor.dart';

class Contestant extends StatefulWidget {
  const Contestant({Key? key}) : super(key: key);

  @override
  _ContestantState createState() => _ContestantState();
}

class _ContestantState extends State<Contestant> {
  static final _formKey = GlobalKey<FormState>();
  LocalStore _store = LocalStore.store;
  File? image;
  String? _fullName;
  String? _age;
  String? _school;
  String? _form;
  String? _userpic;

  Future<void> upLoadPic(File? image, BuildContext context) async {
    final _fileName = basename(image!.path);
    Reference reference =
        FirebaseStorage.instance.ref('Contestant').child(_fileName);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(
      () => setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Uploaded succesfully'),
          ),
        );
      }),
    );
    _userpic = await snapshot.ref.getDownloadURL();
  }

  Future<void> getImage(BuildContext context) async {
    try {
      final _imagePicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_imagePicker != null) {
        setState(() {
          image = File(_imagePicker.path);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Image get')));
        });
      }
      print('The path is: ${_imagePicker!.name}');
    } on Exception catch (e) {
      print(e);
    }
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
                    getImage(context);
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.amber,
                    child: ClipOval(
                      child: SizedBox(
                        height: 195,
                        width: 195,
                        child: image != null
                            ? Image.file(
                                image!,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                FontAwesomeIcons.camera,
                                color: Color(0xFF000000),
                              ),
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
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            _fullName = val;
                          });
                        },
                        validator: ((val) =>
                            val!.length < 3 ? 'Add fullname' : null),
                        textInputAction: TextInputAction.next,
                        decoration: contestDecor.copyWith(
                          hintText: 'Fullname',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        validator: ((val) => val!.isEmpty ? 'Add Age' : null),
                        onChanged: (val) {
                          setState(() {
                            _age = val;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: contestDecor.copyWith(
                          hintText: 'Age',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        validator: ((val) =>
                            val!.length < 3 ? 'Add School' : null),
                        onChanged: (val) {
                          setState(() {
                            _school = val;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: contestDecor.copyWith(
                          hintText: 'School',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        validator: ((val) =>
                            val!.isEmpty ? 'Class required' : null),
                        onChanged: (val) {
                          setState(() {
                            _form = val;
                          });
                        },
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await upLoadPic(image, context).then((value) {
                                _store.addContestant(
                                  fullname: _fullName,
                                  age: _age,
                                  school: _school,
                                  form: _form,
                                  displayPic: _userpic,
                                );
                                Navigator.of(context).pop();
                              });
                            }
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
