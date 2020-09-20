import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/category_types.dart';
import 'package:pikngrocers_client/screens/detailed_category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'All Categories',
            style: TextStyle(fontSize: 15, color: kCategoryColor),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 2.5,
            ),
            itemCount: categoryTypes.length,
            itemBuilder: (context, index) {
              return Container(
                color: kCategoryColor.withOpacity(0.7),
                child: ListTile(
                  title: Text(
                    categoryTypes[index].categoryTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedCategory(
                              categoryTypes[index].categoryTitle,
                              categoryTypes[index].categoryValue,),
                        ),);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
