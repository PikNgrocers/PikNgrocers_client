import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/select_shop.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kHomeColor,
        title: Row(
          children: [
            Column(
              children: [
                Text(
                  'ShopName',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                Text(
                  'city-600015',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShopListScreen()));
              },
              icon: Icon(Icons.edit,),
            ),
          ],
        ),
      ),
      body: Center(child: DelayedList()),
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

          print(time);

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
