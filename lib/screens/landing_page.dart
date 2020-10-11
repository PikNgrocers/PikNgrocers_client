import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/screens/home.dart';
import 'package:pikngrocers_client/screens/mobile_get_number.dart';
import 'package:pikngrocers_client/utils/nointernet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _result;
  SharedPreferences prefs;
  String vendorId;
  String shopName;

  void getConnection() async {
    _result = await Connectivity().checkConnectivity();
    prefs = await SharedPreferences.getInstance();
    vendorId = prefs.get('vendorId');
    shopName = prefs.get('shopName');
  }

  @override
  void initState() {
    getConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (_result == ConnectivityResult.none) {
            return NoInternet();
          }
          if (snapshot.hasData && snapshot.data != null) {
            User user = snapshot.data;
            return Home(vendorId: vendorId,shopName: shopName,userId: user.uid,);
          }
          if(snapshot.data == null){
            return MobileNumberVerify();
          }

          return Center(child: CircularProgressIndicator(),);

        });
  }
}
