import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/landing_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopListScreen extends StatefulWidget {
  final double lat, lon;
  ShopListScreen({this.lat, this.lon});

  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  Stream<List<DocumentSnapshot>> _stream;
  SharedPreferences pref;

  GeoFirePoint center;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('vendors');
  var radius = BehaviorSubject<double>.seeded(3.0);

  getSharedPreference() async {
    pref = await SharedPreferences.getInstance();
  }

  getRadiusDetails() {
    center =
        Geoflutterfire().point(latitude: widget.lat, longitude: widget.lon);
    _stream = radius.switchMap((rad) => Geoflutterfire()
        .collection(collectionRef: collectionReference)
        .within(
            center: center, radius: rad, field: 'position', strictMode: true));
  }

  @override
  void dispose() {
    radius.close();
    super.dispose();
  }

  @override
  void initState() {
    getSharedPreference();
    getRadiusDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          return ShopsListWidget(
            center: center,
            snapshot: snapshot,
            prefs: pref,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ShopsListWidget extends StatelessWidget {
  const ShopsListWidget({
    Key key,
    @required this.prefs,
    @required this.center,
    @required this.snapshot,
  }) : super(key: key);

  final GeoFirePoint center;
  final AsyncSnapshot snapshot;
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Choose A Shop',
          style: TextStyle(color: kHomeColor),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            var dat = snapshot.data[index];
            GeoPoint pos = dat.data()['position']['geopoint'];
            return Card(
              elevation: 3,
              color: Colors.white,
              margin: EdgeInsets.all(5),
              child: ListTile(
                onTap: () {
                  prefs.setString(
                      'vendorId', dat.data()['vendor_id'].toString());
                  prefs.setString(
                      'shopName', dat.data()['shop_name'].toString());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LandingPage(),
                      ),
                      (route) => false);
                },
                leading: Image.asset('assets/images/shop.png'),
                title: Text(
                  '${dat.data()['shop_name']}',
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_city,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${center.distance(lat: pos.latitude, lng: pos.longitude).toStringAsFixed(1)} km',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '8.00AM - 10.00PM',
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
