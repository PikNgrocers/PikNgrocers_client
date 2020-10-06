import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Database {


  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  CollectionReference customerGps = FirebaseFirestore.instance.collection('customer_gps');

  final geo = Geoflutterfire();

  Future<void> updateUserData(
      {String uid,String phno,String username,String email,String photoUrl}) async {
    return await customers
        .doc(uid)
        .set({
      'username' : username,
      'email' : email,
      'ph_no': phno,
      'photoUrl':photoUrl,
    });
  }

  Future<void> customerLocationData(
      {String uid,double lat,double lon,String address}) async {
    GeoFirePoint location = geo.point(latitude: lat, longitude: lon);
    return await customerGps.add({
      'customer_id' : uid,
      'address' : address,
      'position' : location.data,
    });
  }
}