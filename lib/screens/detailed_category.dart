import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/category_types.dart';
import 'package:pikngrocers_client/constants.dart';

class DetailedCategory extends StatefulWidget {
  @override
  _DetailedCategoryState createState() => _DetailedCategoryState();

  final String categoryName;
  final int categoryValue;
  DetailedCategory(this.categoryName, this.categoryValue);
}

class _DetailedCategoryState extends State<DetailedCategory> {
  List<Tab> _tabBarLists;
  List<Center> _tabBarListsViews;
  @override
  void initState() {
    _tabBarLists = List.generate(groceryStaples.length, (index) => Tab(child: Text(groceryStaples[index].title),));
    _tabBarListsViews = List.generate(groceryStaples.length, (index) => Center(child: Text(groceryStaples[index].title),),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: groceryStaples.length,
      child: Scaffold(
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
                  // showSearch(context: context, delegate: Search());
                })
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabBarLists,
          ),
        ),
        body: TabBarView(
          children: _tabBarListsViews,
        ),
      ),
    );
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
