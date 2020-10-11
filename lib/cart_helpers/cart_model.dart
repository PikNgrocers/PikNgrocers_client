import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartModel {
  final String productName;
  final String cartId;
  final int price;
  final int qty;
  final String productId;

  CartModel(
      {this.cartId, this.price, this.productName, this.qty, this.productId});
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
                productId: productId,
              ));
    }
    totalAmount();
    notifyListeners();
  }

  void removeItem({String productId}) {
    _items.remove(productId);
    notifyListeners();
  }

  void plusItemQuantity({String productId}) {
    if (_items[productId].qty == 5) {
      return;
    }

    _items.update(
      productId,
      (value) => CartModel(
          productName: value.productName,
          productId: value.productId,
          price: value.price,
          cartId: value.cartId,
          qty: value.qty + 1),
    );
    totalAmount();
    notifyListeners();
  }

  void minusItemQuantity({String productId}) {
    if (_items[productId].qty == 1) {
      removeItem(productId: productId);
    }
    _items.update(
      productId,
      (value) => CartModel(
          productId: value.productId,
          productName: value.productName,
          price: value.price,
          cartId: value.cartId,
          qty: value.qty - 1),
    );
    totalAmount();
    notifyListeners();
  }

  double totalAmount() {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.qty;
    });
    return total;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
