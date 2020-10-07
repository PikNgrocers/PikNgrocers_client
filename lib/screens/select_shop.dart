import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class ShopListScreen extends StatefulWidget {
  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {

  Stream<List<DocumentSnapshot>> stream;

    GeoFirePoint center = Geoflutterfire().point(latitude: 9.961477, longitude: 78.10068);
    var collectionReference = FirebaseFirestore.instance.collection('vendors');
    double radius = 50;
    String field = 'position';



  @override
  void initState() {
    stream = Geoflutterfire().collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field,strictMode: true);
    // stream.listen((event) {
    //   event.forEach((element) {
    //     print('element data${element.data()['ph_no']}');
    //   });
    // });
    //TODO: some what finded radius have to implement it.
    stream.forEach((element) {
      print('element data${element.first['ph_no']}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
