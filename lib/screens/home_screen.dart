import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grosmetique/models/cart.dart';
import 'package:grosmetique/screens/connection_status.dart';
import 'package:grosmetique/widgets/badge.dart';
import 'package:grosmetique/widgets/buildSearch.dart';
import 'package:provider/provider.dart';
import 'products/cart_screen.dart';
import '../widgets/buildDrawerApp.dart';
import '../widgets/brands/buildBrandsCard.dart';
import '../widgets/categories/buildCategoriesCard.dart';
import '../widgets/buildProductGrid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var listSearch = [];

  Future getData() async {
    var list = [];
    var snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    var docs = snapshot.docs;
    for (int i = 0; i < docs.length; i++) {
      list.add(docs[i]['title']);
    }
    listSearch = list;
  }

  @override
  void initState() {
    getData();
    //setState(() {});

    print(listSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).primaryColor,
              title: const Text(
                'Grosmetique',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: BuildSearch(list: listSearch));
                  },
                ),
                Consumer<Cart>(
                  builder: (_, cart, ch) => Badge(
                    child: ch,
                    value: cart.itemCOunt.toString(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => CartScreen()));
                    },
                  ),
                ),
              ],
            ),
            drawer: BuildDrawerApp(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Carousel(
                      images: [
                        Image.network(
                                'https://cdn.shopify.com/s/files/1/0486/4694/6965/files/AFFICHER_PLUS_900x.png?v=1601493570')
                            .image,
                        Image.network(
                                'https://cdn.shopify.com/s/files/1/0486/4694/6965/files/promotionblanc_360x.png?v=1602342684')
                            .image,
                      ],
                      boxFit: BoxFit.cover,
                      dotColor: Colors.purple,
                      dotBgColor: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Brands',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    height: 125,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('marques')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final docs = snapshot.data.docs;
                          final lengthDoc = docs.length;
                          if (lengthDoc != 0) {
                            return ListView.builder(
                              itemCount: docs.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return BuildBrandsCard(docs[index].data());
                              },
                            );
                          } else {
                            return Center(
                                child: Text('You don\'t have Brand yet'));
                          }
                        }
                        if (snapshot.data == null) {
                          return Center(
                              child: Text('You don\'t have Brand yet'));
                        }
                        if (snapshot.error || snapshot.hasError) {
                          return Center(
                            child: Text(
                                'We have error in server contact devlopper to continue use the app'),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: const Text(
                      'Categories',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    height: 300,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final docs = snapshot.data.docs;
                          final lengthDoc = docs.length;
                          if (lengthDoc != 0) {
                            return ListView.builder(
                              itemCount: docs.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return BuildCategoriesCard(docs[index].data());
                              },
                            );
                          } else {
                            return Center(
                                child: Text('You don\'t have Brand yet'));
                          }
                        }
                        if (snapshot.data == null) {
                          return Center(
                              child: Text('You don\'t have Categorie yet'));
                        }
                        if (snapshot.error || snapshot.hasError) {
                          return Center(
                            child: Text(
                                'We have error in server contact devlopper to continue use the app'),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: const Text(
                      'Product',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    height: 300,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final docs = snapshot.data.docs;
                          return ListView.builder(
                            itemCount: docs.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return BuildProductGrid(
                                  docs[index].data(), docs[index].id);
                            },
                          );
                        }
                        if (snapshot.data == null) {
                          return Center(
                              child: Text('You don\'t have Product yet'));
                        }
                        if (snapshot.error || snapshot.hasError) {
                          return Center(
                            child: Text(
                                'We have error in server contact devlopper to continue use the app'),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConnextionStatus(),
        ],
      ),
    );
  }
}
