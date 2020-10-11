import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/cart_screen.dart';
import 'package:pikngrocers_client/screens/category_screen.dart';
import 'package:pikngrocers_client/screens/home_screen.dart';
import 'package:pikngrocers_client/screens/profile.dart';

class Home extends StatefulWidget {
  final String vendorId;
  final String shopName;
  final String userId;
  Home({this.vendorId, this.shopName, this.userId});

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
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomePage(
            shopName: widget.shopName,
            vendorId: widget.vendorId,
            userId: widget.userId,
          ),
          CategoryPage(
            vendorId: widget.vendorId,
          ),
          CartScreen(),
          ProfilePage(),
        ],
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
            label: 'CATEGORIES',
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
        onTap: (index) {
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
