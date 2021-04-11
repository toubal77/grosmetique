import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'buildProdCategorie.dart';

class BuildProductCategorie extends StatelessWidget {
  static final routeName = '\prod_categorie';

  @override
  Widget build(BuildContext context) {
    final catName = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products $catName'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('categorie', isEqualTo: catName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final docs = snapshot.data.docs;
            final lengthDoc = docs.length;
            if (lengthDoc != 0) {
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return BuildProdCategorie(docs[index].data(), docs[index].id);
                },
              );
            } else {
              return Center(child: Text('You don\'t have Product yet'));
            }
          }
          if (snapshot.data == null) {
            return Center(child: Text('You don\'t have Product yet'));
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
