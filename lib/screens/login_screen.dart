import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Expanded(
              child: Center(
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            Container(height: 400,
            child: TextField(

            ),),
          ],
        ),
      ),
    );
  }
}
