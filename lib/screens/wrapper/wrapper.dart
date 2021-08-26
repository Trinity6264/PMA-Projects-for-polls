import 'package:flutter/material.dart';
import 'package:pma/models/fire_user.dart';
import 'package:pma/screens/wrapper/authentication/authentication.dart';
import 'package:pma/screens/wrapper/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    print(user?.userName);
    return user != null ? Home() : Authentication();
  }
}
