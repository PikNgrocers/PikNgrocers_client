import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/cart.dart';
import 'package:pikngrocers_client/screens/category.dart';
import 'package:pikngrocers_client/screens/home_screen.dart';
import 'package:pikngrocers_client/screens/profile.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          CategoryPage(),
          CartPage(),
          ProfilePage(),
        ],
        onPageChanged: (page){
          setState(() {
            _currentIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 15.0,
        selectedFontSize: 10.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
            backgroundColor: kHomeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label:'CATEGORIES',
            backgroundColor: kCategoryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'CART',
            backgroundColor: kCartColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'ACCOUNT',
            backgroundColor: kAccountColor,
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
