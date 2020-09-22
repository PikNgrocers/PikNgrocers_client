import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pikngrocers_client/constants.dart';

class NetWorkTester extends StatefulWidget {
  @override
  _NetWorkTesterState createState() => _NetWorkTesterState();
}

class _NetWorkTesterState extends State<NetWorkTester> {
  checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Network Available');
      }
    } on SocketException catch (_) {
      Navigator.pushReplacementNamed(context, '/noint');
    }
  }

  @override
  void initState() {
    checkNetwork();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            setState(() {
              print('Something went wrong');
            });
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print('Done');
          }
          return SpinKitWave(
            color: kMobileVerifyFontColor,
            size: 30.0,
          );
        });
  }
}
