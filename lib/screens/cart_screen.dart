import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/cart_helpers/cart_item.dart';
import 'package:pikngrocers_client/cart_helpers/cart_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: cart.itemCount == 0 ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/empty_cart.png'),
            Center(child: Text('Empty Cart'),),
          ],
        ),
      )  : Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) {
                    return CartItem(
                      price: cart.items.values.toList()[index].price,
                      productId: cart.items.keys.toList()[index],
                      productName: cart.items.values.toList()[index].productName,
                      qty: cart.items.values.toList()[index].qty,
                    );
                  }),
            ),
            FlatButton(onPressed: (){}, child: Text('CHECKOUT'),color: Colors.green,textColor: Colors.white,),
          ],
        ),
      ),
    );
  }
}
