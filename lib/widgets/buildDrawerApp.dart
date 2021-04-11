import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grosmetique/home_widget.dart';
import 'package:grosmetique/screens/authScreen/auth_screen.dart';
import 'package:grosmetique/screens/contact.dart';
import '../screens/products/order_screen.dart';
import '../screens/products/cart_screen.dart';
import '../models/auth.dart';

class BuildDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 100,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: FutureBuilder<String>(
                    future: AuthData().getUserUsername,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Welcome to ${snapshot.data}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return HomeWidget();
                      },
                    ),
                  );
                },
                child: ListTile(
                  title: const Text('My Shop'),
                  subtitle: const Text('Shop'),
                  leading: Icon(Icons.shop),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return CartScreen();
                      },
                    ),
                  );
                },
                child: ListTile(
                  title: const Text('My Cart'),
                  subtitle: const Text('Purchase'),
                  leading: Icon(Icons.shopping_cart),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return OrderScreen();
                      },
                    ),
                  );
                },
                child: ListTile(
                  title: const Text('My Orders'),
                  subtitle: const Text('Shopping'),
                  leading: Icon(Icons.payment),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return ContactUs();
                      },
                    ),
                  );
                },
                child: ListTile(
                  title: const Text('Contact us'),
                  subtitle: const Text('Contact'),
                  leading: Icon(Icons.contact_support),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return AuthScreen();
                    }),
                  );
                },
                child: ListTile(
                  title: Text('Log Out'),
                  subtitle: Text('Exit App'),
                  leading: Icon(Icons.exit_to_app),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Equipe Grosmetique',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '2021 / 1.0.2',
                  style: TextStyle(
                    fontSize: 7.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
