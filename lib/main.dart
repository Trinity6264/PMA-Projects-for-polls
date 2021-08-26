import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pma/local_services/firebase_services/fire_storage.dart';
import 'package:pma/local_services/firebase_services/firebase_auth.dart';
import 'package:pma/models/fire_user.dart';
import 'package:pma/screens/loading.dart';
import 'package:pma/screens/otpScreen.dart';
import 'package:pma/screens/wrapper/authentication/authentication.dart';
import 'package:pma/screens/wrapper/authentication/sign_in.dart';
import 'package:pma/screens/wrapper/authentication/sign_up.dart';
import 'package:pma/screens/wrapper/home/home.dart';
import 'package:pma/screens/wrapper/home/pages/load_screen.dart';
import 'package:pma/screens/wrapper/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<CustomUser?>.value(
          value: FireAuth.auth.userStatus,
          initialData: CustomUser(),
        ),
        ChangeNotifierProvider.value(
          value: FireAuth.auth,
        ),
      ],
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PMA Entertainment'.toUpperCase(),
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => Loading(),
          '/home': (_) => Home(),
          '/wrapper': (_) => Wrapper(),
          '/signIn': (_) => SignIn(),
          '/signUp': (_) => SignUp(),
          '/authentication': (_) => Authentication(),
          '/otp': (_) => OtpScreen(),
          'load': (_) => LoadingScreen(),
        },
      ),
    );
  }
}
