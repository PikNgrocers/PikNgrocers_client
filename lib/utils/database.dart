import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:pikngrocers_client/cart_helpers/cart_model.dart';

class Database {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

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

  Future<void> addOrders(
      {String vendorId,
      String userId,
      List<CartModel> cartProducts,
      double total}) async {
    return await orders.doc().set({
      'OrderId': DateTime.now().toString(),
      'UserId': userId,
      'VendorId': vendorId,
      'products': cartProducts
          .map((e) => {
                'ProductId': e.productId,
                'ProductName': e.productName,
                'Quantity': e.qty,
                'Price': e.price,
              })
          .toList(),
      'TotalAmount': total,
      'OrderStatus': 'Waiting',//Accepted,Packed
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

  profileData({String userId}){
    return customers.doc(userId).get();
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

  orderDetails({String userId}){
    return orders.where('UserId',isEqualTo: userId).snapshots();
  }
}
