import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grosmetique/models/auth.dart';
import 'package:grosmetique/widgets/buildDrawerApp.dart';
import 'package:grosmetique/widgets/brands/buildProdMarque.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final userId = AuthData().getUserId;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Favorites Items',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: BuildDrawerApp(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final docs = snapshot.data.docs;
            final lengthDoc = docs.length;
            if (lengthDoc != 0) {
              print(docs);
              return ListView.builder(
                itemCount: lengthDoc,
                itemBuilder: (ctx, index) {
                  return BuildProdMarque(docs[index].data(), docs[index].id);
                },
              );
            } else {
              return Center(child: Text('You don\'t have Favorite Item yet'));
            }
          }
          if (snapshot.data == null) {
            return Center(child: Text('You don\'t have Brand yet'));
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
    );
  }
}
