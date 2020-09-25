import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/utils/auth_helper.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: kAccountColor,
          textColor: Colors.white,
          onPressed: (){
            AuthHelper.logout();
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
