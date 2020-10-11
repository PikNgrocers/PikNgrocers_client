import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/cart_helpers/cart_model.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/home_models/product_model.dart';
import 'package:pikngrocers_client/screens/select_shop.dart';
import 'package:pikngrocers_client/utils/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({this.shopName, this.vendorId, this.userId});
  final String shopName;
  final String vendorId;
  final String userId;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double lat, lon;
  getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lat = prefs.getDouble('latitude');
    lon = prefs.getDouble('longitude');
  }

  @override
  void initState() {
    getSharedPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeColor.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: FlatButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShopListScreen(
                  lat: lat,
                  lon: lon,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.edit,
            color: kHomeColor,
          ),
          label: Column(
            children: [
              Text(
                '${widget.shopName}',
                style: TextStyle(color: kHomeColor, fontSize: 17),
              ),
              Text(
                'Change shop',
                style: TextStyle(color: kHomeColor, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Store Specials',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              HomeParts(
                  userId: widget.userId,
                  types: Database().homePartOneData(vendorId: widget.vendorId)),
              SizedBox(
                height: 10,
              ),
              Text(
                'Best Offers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              HomeParts(
                  userId: widget.userId,
                  types: Database().homePartTwoData(vendorId: widget.vendorId)),
              SizedBox(
                height: 10,
              ),
              Text(
                'Product LessThan ₹100',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              HomeParts(
                  userId: widget.userId,
                  types:
                      Database().homePartThreeData(vendorId: widget.vendorId)),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeParts extends StatelessWidget {
  const HomeParts({
    this.userId,
    this.types,
  });
  final String userId;
  final Stream<QuerySnapshot> types;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      height: 210,
      child: StreamBuilder<QuerySnapshot>(
        stream: types,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something happen unusual');
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.docs.length == 0) {
              return Container(
                height: 190,
                width: 150,
                child: Center(
                  child: Text('No Products to Display'),
                ),
              );
            } else {
              List<Product> _productList = snapshot.data.docs
                  .map((e) => Product(
                        productCat: e.data()['Product_category'],
                        productId: e.data()['Product_Id'],
                        productQuantity: e.data()['Product_Quantity'],
                        productName: e.data()['Product_Name'],
                        price: e.data()['Price'],
                        offerPrice: e.data()['Offer_price'],
                        vendorId: e.data()['vendor_Id'],
                      ))
                  .toList();

              return Container(
                height: 190,
                width: 150,
                child: ListView.builder(
                    itemCount: _productList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          height: 190,
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/basket.png',
                                  height: 90,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _productList[index].offerPrice == 0
                                          ? Text(
                                              '₹${_productList[index].price.toString()}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  '₹${_productList[index].offerPrice.toString()}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '₹${_productList[index].price.toString()}',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: Text(
                                          '${_productList[index].productQuantity}',
                                          style: TextStyle(fontSize: 8),
                                        ),
                                      ),
                                      Text(
                                        '${_productList[index].productName}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  if (cart.items.containsKey(
                                      _productList[index].productId)) {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Already Added to cart'),
                                        duration: Duration(milliseconds: 100),
                                      ),
                                    );
                                    return;
                                  }
                                  int offer = _productList[index].offerPrice;
                                  int price = _productList[index].price;
                                  cart.addItem(
                                    productName:
                                        _productList[index].productName,
                                    productId: _productList[index].productId,
                                    price: offer == 0 ? price : offer,
                                  );
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Product Added'),
                                      duration: Duration(milliseconds: 100),
                                    ),
                                  );
                                },
                                child: Text('Add To Cart'),
                                color: kCartColor,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }
          }

          return Container(
            height: 190,
            width: 150,
            child: Card(
              color: Colors.white24,
            ),
          );
        },
      ),
    );
  }
}

class DelayedList extends StatefulWidget {
  @override
  _DelayedListState createState() => _DelayedListState();
}

class _DelayedListState extends State<DelayedList> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });

    return isLoading
        ? ShimmerList()
        : DataList(
            timer); //This is for now only... if is loading is false we have to load the cards
  }
}

class DataList extends StatelessWidget {
  final Timer timer;

  DataList(this.timer);

  @override
  Widget build(BuildContext context) {
    timer.cancel();
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Text(i.toString()),
        );
      },
    );
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.deepPurple[200],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 260;
    double containerHeight = 15;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.35,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.70,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.70,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    height: containerHeight,
                    width: containerWidth * 0.70,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 60),
                  Container(
                    height: 18,
                    width: 30,
                    color: Colors.grey,
                  )
                ],
              ),
              SizedBox(height: 5),
            ],
          )
        ],
      ),
    );
  }
}
