import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grosmetique/data/products_data.dart';
import 'package:grosmetique/home_widget.dart';
import 'widgets/brands/buildProductMarque.dart';
import 'widgets/categories/buildProductCategorie.dart';
import 'package:provider/provider.dart';
import './models/auth.dart';
import './models/cart.dart';
import './models/orders.dart';
import 'screens/admin/users/addUser_screen.dart';
import 'screens/admin/users/detail_user_screen.dart';
import 'screens/admin/edit_product_screen.dart';
import 'screens/authScreen/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthData()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Product()),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<AuthData, Orders>(
          update: (ctx, auth, previousProducts) => Orders(auth.getUserId,
              previousProducts == null ? [] : previousProducts.orders),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grosmetique',
        theme: ThemeData(
          accentColor: Colors.deepOrange,
          primaryColor: Colors.purple,
        ),
        home: StreamBuilder(
          stream: AuthData().onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;
              if (user == null) {
                return MyHomePage();
              } else {
                return HomeWidget();
              }
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        routes: {
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          AddUserScreen.routeName: (ctx) => AddUserScreen(),
          UserDetailScreen.routeName: (ctx) => UserDetailScreen(),
          BuildProductCategorie.routeName: (ctx) => BuildProductCategorie(),
          BuildProductMarque.routeName: (ctx) => BuildProductMarque(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    //AuthScreen();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return AuthScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(181, 72, 126, 1),
      body: Center(
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
            ),
            width: 200,
            height: 60,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Grosmetique',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
