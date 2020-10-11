import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartModel {
  final String productName;
  final String cartId;
  final int price;
  final int qty;

  CartModel({this.cartId, this.price, this.productName, this.qty});
}

class Cart with ChangeNotifier {
  Map<String, CartModel> _items = {};

  Map<String, CartModel> get items => _items;

  int get itemCount {
    return _items.length;
  }

  void addItem({String productId, String productName, int price}) {
    if (_items.containsKey(productId)) {
      print('Already added');
    } else {
      _items.putIfAbsent(
          productId,
          () => CartModel(
                qty: 1,
                price: price,
                productName: productName,
                cartId: DateTime.now().toString(),
              ));
    }
    notifyListeners();
  }

  void removeItem({String productId}) {
    _items.remove(productId);
    notifyListeners();
  }

  void plusItemQuantity({String productId}) {

    if(_items[productId].qty == 5) {
      return ;
    }

    _items.update(
      productId,
      (value) => CartModel(
          productName: value.productName,
          price: value.price,
          cartId: value.cartId,
          qty: value.qty + 1),
    );
    notifyListeners();
  }
  void minusItemQuantity({String productId}) {
    if(_items[productId].qty == 1) {
      removeItem(productId: productId);
    }
    _items.update(
      productId,
          (value) => CartModel(
          productName: value.productName,
          price: value.price,
          cartId: value.cartId,
          qty: value.qty - 1),
    );
    notifyListeners();
  }
}
