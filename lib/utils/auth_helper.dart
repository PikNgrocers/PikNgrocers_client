import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/user_location.dart';
import 'package:pikngrocers_client/utils/database.dart';

class AuthHelper {
  FirebaseAuth _auth = FirebaseAuth.instance;
  signInWithGoogle() async {
    final GoogleSignInAccount _googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication _googleAuth =
        await _googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);
    return result.user;
  }

  phoneAuth({String phoneNumber, BuildContext context}) async {
    TextEditingController _otpController = TextEditingController();
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        final result = await _auth.signInWithCredential(credential);
        if (result.user != null) {
          User user = result.user;
          try{
            Database().updateUserData(uid: user.uid,email: user.email,phno: user.phoneNumber,photoUrl: user.photoURL);
          } catch(e){
            print(e);
          }
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LocationScreen(uid: result.user.uid,)), (route) => false);
        } else {
          print("Error");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return OtpEnterScreen(
                otpController: _otpController,
                auth: _auth,
                verificationId: verificationId,
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  logout() {
    GoogleSignIn().signOut();
    return _auth.signOut();
  }
}

class OtpEnterScreen extends StatelessWidget {
  const OtpEnterScreen({
    Key key,
    @required TextEditingController otpController,
    @required FirebaseAuth auth,
    @required verificationId,
  })  : _otpController = otpController,
        _auth = auth,
        _verificationId = verificationId,
        super(key: key);

  final TextEditingController _otpController;
  final FirebaseAuth _auth;
  final String _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: kMobileVerifyFontColor,),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/enter_otp.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 10,
                ),
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
                TextField(
                  controller: _otpController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'OTP Number',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
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
                  onPressed: () async {
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: _verificationId,
                        smsCode: _otpController.text);
                    final result = await _auth.signInWithCredential(credential);
                    if (result.user != null) {
                      User user = result.user;
                      try{
                        Database().updateUserData(uid: user.uid,email: user.email,phno: user.phoneNumber,photoUrl: user.photoURL);
                      } catch(e){
                        print(e);
                      }
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LocationScreen(uid: result.user.uid,)), (route) => false);
                    } else {
                      print("Error");
                    }
                  },
                  color: kMobileVerifyFontColor,
                  textColor: Colors.white,
                  child: Text('Verify OTP'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
