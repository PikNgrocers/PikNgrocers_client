import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Database {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  CollectionReference carts = FirebaseFirestore.instance.collection('carts');

  final geo = Geoflutterfire();

  Future<void> updateUserData(
      {String uid,
      String phno,
      String username,
      String email,
      String photoUrl}) async {
    return await customers.doc(uid).set({
      'customer_Id': uid,
      'username': username,
      'email': email,
      'ph_no': phno,
      'photoUrl': photoUrl,
    });
  }

  Future<void> customerLocationData(
      {String uid, double lat, double lon, String address}) async {
    GeoFirePoint location = geo.point(latitude: lat, longitude: lon);
    return await customers.doc(uid).update({
      'address': address,
      'position': location.data,
    });
  }

  showProductData({String catType, String uid}) {
    return products
        .where('vendor_Id', isEqualTo: uid)
        .where('Product_category', isEqualTo: catType)
        .snapshots();
  }

  homePartOneData({String vendorId}) {
    return products
        .where('vendor_Id', isEqualTo: vendorId)
        .limit(20)
        .snapshots();
  }

  homePartTwoData({String vendorId}) {
    return products
        .where('vendor_Id', isEqualTo: vendorId)
        .where('Offer_price', isGreaterThan: 0)
        .limit(20)
        .snapshots();
  }

  homePartThreeData({String vendorId}) {
    return products
        .where('vendor_Id', isEqualTo: vendorId)
        .where('Price', isLessThan: 100)
        .limit(20)
        .snapshots();
  }

  addToCart(
      {String userId,
      String productId,
      String productName,
      String vendorId,
      int price,
      int offerPrice}) async {
    return await carts.doc().set({
      'UserId': userId,
      'ProductId': productId,
      'VendorId': vendorId,
      'ProductName': productName,
      'Price': offerPrice == 0 ? price : offerPrice,
      'Quantity': 1,
    });
  }

  showCarts({String vendorId, String userId}) {
    return carts
        .where('VendorId', isEqualTo: vendorId)
        .where('UserId', isEqualTo: userId)
        .snapshots();
  }
}
