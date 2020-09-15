import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50,),
          Image.asset('assets/images/selected.png'),
          SizedBox(height: 50,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
          )
        ],
      ),
    );
  }
}
