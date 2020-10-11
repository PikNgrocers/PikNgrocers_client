import 'package:flutter/material.dart';
import 'package:pikngrocers_client/cart_helpers/cart_model.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final int price;
  final int qty;
  final String productName;

  CartItem({this.productName, this.productId, this.qty, this.price});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: kCartColor,
      ),
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                cart.removeItem(productId: productId);
              }),
          Expanded(
              child: Text(
            '$productName',
            style: TextStyle(color: Colors.white),
          )),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove,size: 13,),
                  onPressed: () {
                    if(qty == 1){
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Product Removed'),duration: Duration(milliseconds: 100),),);
                    }
                    cart.minusItemQuantity(productId: productId);
                  },
                ),
                Text('$qty'),
                IconButton(
                  icon: Icon(Icons.add,size: 13,),
                  onPressed: () {
                    if(qty == 5){
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Only 5 Quantity allowed'),duration: Duration(milliseconds: 100),),);
                    }
                    cart.plusItemQuantity(productId: productId);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              '₹ ${price * qty}',
              style: TextStyle(color: Colors.white,fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
