import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/category_helpers/showProduct.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/category_types.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final String uid = 'EHKnHsHi3GY1zAcjfLs8gKZJdR43';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'All Categories',
          style: TextStyle(fontSize: 15, color: kCategoryColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 2.5,
            ),
            itemCount: categoryTypes.length,
            itemBuilder: (context, index) {
              return FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                onPressed:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductList(
                        uid: uid,
                        catType: categoryTypes[index].categoryTitle,
                      ),
                    ),
                  );
                },
                color: kCategoryColor.withOpacity(0.7),
                child: Center(
                  child: Text(
                    categoryTypes[index].categoryTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
