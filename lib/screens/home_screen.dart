import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/select_shop.dart';
import 'package:pikngrocers_client/utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({this.shopName, this.vendorId});
  final String shopName;
  final String vendorId;
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
              homeParts(context,
                  Database().homePartOneData(vendorId: widget.vendorId)),
              SizedBox(
                height: 10,
              ),
              //TODO:think about placing grid view here
              // Text(
              //   'Shop By Category',
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                'Best Offers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              homeParts(context,
                  Database().homePartTwoData(vendorId: widget.vendorId)),
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
              homeParts(context,
                  Database().homePartThreeData(vendorId: widget.vendorId)),
            ],
          ),
        ),
      ),
    );
  }

  Container homeParts(BuildContext context, Stream<QuerySnapshot> types) {
    return Container(
      height: 210,
      child: StreamBuilder<QuerySnapshot>(
        stream: types,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something happen unusual');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 190,
              width: 150,
              child: Card(
                color: Colors.white24,
              ),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var dat = snapshot.data.docs;
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dat[index].data()['Offer_price'] == 0
                                    ? Text(
                                        '₹${dat[index].data()['Price'].toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            '₹${dat[index].data()['Offer_price'].toString()}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '₹${dat[index].data()['Price'].toString()}',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Text(
                                    '${dat[index].data()['Product_Quantity']}',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                                Text(
                                  '${dat[index].data()['Product_Name']}',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text('Add To Cart'),
                          color: kCartColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              });
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
