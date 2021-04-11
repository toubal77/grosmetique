import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/admin/buildProductListTile.dart';
import 'edit_product_screen.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final docs = snapshot.data.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, index) => Column(
                children: <Widget>[
                  BuildProductListTile(docs[index].data()),
                ],
              ),
            );
          }
          if (snapshot.data == null) {
            return Center(child: Text('You don\'t have Product yet'));
          }
          if (snapshot.error || snapshot.hasError) {
            return Center(
                child: Text(
                    'We have error in server contact devlopper to continue use the app'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
