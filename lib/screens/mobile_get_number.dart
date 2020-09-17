import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';

class MobileNumberVerify extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMobileVerifyFontColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(100),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/enter_number.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    mobileTextForm(context),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Divider(
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RaisedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      color: Colors.white,
                      textColor: Colors.black87,
                      icon: Icon(Icons.mail),
                      label: Text('Continue with Email'),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            width: 30,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form mobileTextForm(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (val) =>
                val.isEmpty ? "Phone Number Should not empty" : null,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.0,
            ),
            autofocus: true,
            cursorColor: kMobileVerifyFontColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: 'Phone Number',
              prefixIcon: Icon(
                Icons.phone_iphone,
                color: kMobileVerifyFontColor,
                size: 17.0,
              ),
              prefix: Text('+91'),
              labelStyle: TextStyle(color: kMobileVerifyFontColor),
            ),
            showCursor: true,
          ),
          RaisedButton(
            onPressed: () {
              if (_formkey.currentState.validate()) {
                Navigator.pushNamed(context, '/verify_screen');
              }
            },
            padding: EdgeInsets.all(0),
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            textColor: Colors.white,
            child: Text(
              'Send OTP',
            ),
          ),
        ],
      ),
    );
  }
}
