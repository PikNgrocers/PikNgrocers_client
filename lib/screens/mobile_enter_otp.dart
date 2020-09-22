import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';

class MobileNumberOTP extends StatefulWidget {
  @override
  _MobileNumberOTPState createState() => _MobileNumberOTPState();
}

class _MobileNumberOTPState extends State<MobileNumberOTP> {
  TextEditingController _otpController = TextEditingController();


  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/enter_otp.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter OTP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kMobileVerifyFontColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'We have sent you an OTP for phone number verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _otpController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'OTP Number',
                        hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kMobileVerifyFontColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kMobileVerifyFontColor),
                        ),
                      ),
                      style: TextStyle(
                          color: kMobileVerifyFontColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      cursorColor: kMobileVerifyFontColor,
                      cursorWidth: 5,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: kMobileVerifyFontColor,
                      textColor: Colors.white,
                      child: Text('Verify OTP'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
}
