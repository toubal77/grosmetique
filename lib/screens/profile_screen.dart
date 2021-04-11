import 'package:flutter/material.dart';
import 'package:grosmetique/screens/admin/all_orders.dart';
import 'package:grosmetique/screens/admin/users/all_users.dart';
import 'package:grosmetique/screens/connection_status.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth.dart';
import '../screens/information_screen.dart';
import 'products/order_screen.dart';
import 'authScreen/auth_screen.dart';
import 'authScreen/edit_password.dart';
import 'admin/all_products.dart';
import 'admin/categories_screen.dart';
import 'admin/marque_screen.dart';
import 'admin/users/setting_screen.dart';
import '../widgets/buildDrawerApp.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Profile',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            drawer: BuildDrawerApp(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 110,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 2.0,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: FutureBuilder<String>(
                                future: AuthData().getUserUsername,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Time:',
                                  style: const TextStyle(
                                    //  fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy hh:mm')
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ProfileMenu(
                      'Orders',
                      Icons.payment,
                      () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return OrderScreen();
                            },
                          ),
                        );
                      },
                    ),
                    FutureBuilder<bool>(
                      future: AuthData().getUserAdmin,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasData == true) {
                          if (snapshot.data) {
                            return Column(
                              children: <Widget>[
                                ProfileMenu(
                                  'All Orders',
                                  Icons.all_inbox,
                                  () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return AllOrders();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                ProfileMenu(
                                  'All Users',
                                  Icons.person,
                                  () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return AllUsers();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                ProfileMenu(
                                  'Products',
                                  Icons.post_add,
                                  () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return AllProducts();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                ProfileMenu(
                                  'Categories',
                                  Icons.category,
                                  () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return CategoriesScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                ProfileMenu(
                                  'Marques',
                                  Icons.category,
                                  () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return MarqueScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                    ProfileMenu(
                      'Settings',
                      Icons.settings,
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return SettingScreen();
                            },
                          ),
                        );
                      },
                    ),
                    ProfileMenu(
                      'Change Password',
                      Icons.lock,
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return EditPassword();
                            },
                          ),
                        );
                      },
                    ),
                    ProfileMenu(
                      'Terms & Condition',
                      Icons.low_priority_sharp,
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return InformationScreen();
                            },
                          ),
                        );
                      },
                    ),
                    ProfileMenu('Log Out', Icons.exit_to_app, () {
                      FirebaseAuth.instance.signOut();

                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return AuthScreen();
                        }),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          ConnextionStatus(),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function press;
  ProfileMenu(this.title, this.icon, this.press);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.purple,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
