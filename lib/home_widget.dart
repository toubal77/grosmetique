import 'package:flutter/material.dart';
import 'package:grosmetique/screens/home_screen.dart';
import 'package:grosmetique/screens/products/cart_screen.dart';
import 'package:grosmetique/screens/profile_screen.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsOptions = [
      HomeScreen(),
      // FavoriteScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    void onTapBottomNavigation(index) {
      setState(() {
        selectIndex = index;
      });
    }

    return Scaffold(
      body: widgetsOptions.elementAt(selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        onTap: onTapBottomNavigation,
        currentIndex: selectIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'Favorite',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
