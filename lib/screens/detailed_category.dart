import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';

class DetailedCategory extends StatefulWidget {
  @override
  _DetailedCategoryState createState() => _DetailedCategoryState();

  final String categoryName;
  final int categoryValue;
  DetailedCategory(this.categoryName, this.categoryValue);
}

class _DetailedCategoryState extends State<DetailedCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kCategoryColor,
          elevation: 0,
          title: Text(
            widget.categoryName,
            style: TextStyle(fontSize: 15.0),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                })
          ],
          // bottom: PreferredSize(
          //   preferredSize: Size(10, 30),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       filled: true,
          //         fillColor: Colors.white,
          //         suffixIcon: Icon(Icons.search,color: kCategoryColor,),
          //         contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          //         hintText: 'Search eg. atta,salt,pepper',
          //         isDense: true,
          //         enabledBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: kCategoryColor,width: 2),
          //           borderRadius: BorderRadius.circular(50),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(50),
          //           borderSide: BorderSide(color: kCategoryColor),
          //         )),
          //     style: TextStyle(
          //       fontSize: 13,
          //       color: Colors.grey,
          //     ),
          //   ),
          // ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [],
          ),
        ));
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
