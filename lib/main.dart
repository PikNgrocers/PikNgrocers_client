import 'package:flutter/material.dart';
import 'package:pikngrocers_client/screens/Register_screen.dart';
import 'package:pikngrocers_client/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => LoginPage(),
        '/register':(context) => RegisterPage(),
      },
    );
  }
}
