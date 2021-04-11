import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'buildProdMarque.dart';

class BuildProductMarque extends StatelessWidget {
  static final routeName = '/marque_prod';
  @override
  Widget build(BuildContext context) {
    final marqueName = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products $marqueName'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('marque', isEqualTo: marqueName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
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
                  return BuildProdMarque(docs[index].data(), docs[index].id);
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
