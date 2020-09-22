import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/screens/Register_screen.dart';
import 'package:pikngrocers_client/screens/category.dart';
import 'package:pikngrocers_client/screens/detailed_category.dart';
import 'package:pikngrocers_client/screens/home.dart';
import 'package:pikngrocers_client/screens/login_screen.dart';
import 'package:pikngrocers_client/screens/mobile_enter_otp.dart';
import 'package:pikngrocers_client/screens/mobile_get_number.dart';
import 'package:pikngrocers_client/screens/nointernet.dart';
import 'package:pikngrocers_client/utils/network_checker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/nettest',
      routes: {
        '/login':(context) => LoginPage(),
        '/register':(context) => RegisterPage(),
        '/mobile_verify':(context) => MobileNumberVerify(),
        '/verify_screen':(context) => MobileNumberOTP(),
        '/home':(context) => Home(),
        '/noint':(context) => NoInternet(),
        '/nettest':(context) => NetWorkTester(),
      },
    );
  }
}
