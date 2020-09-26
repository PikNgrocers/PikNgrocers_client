import 'package:flutter/material.dart';
import 'package:pikngrocers_client/screens/Register_screen.dart';
import 'package:pikngrocers_client/screens/home.dart';
import 'package:pikngrocers_client/screens/landing_page.dart';
import 'package:pikngrocers_client/screens/login_screen.dart';
import 'package:pikngrocers_client/screens/mobile_get_number.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => LandingPage(),
        '/login':(context) => LoginPage(),
        '/register':(context) => RegisterPage(),
        '/mobile_verify':(context) => MobileNumberVerify(),
        '/home':(context) => Home(),
      },
    );
  }
}
