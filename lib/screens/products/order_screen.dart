import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grosmetique/models/auth.dart';
import 'package:grosmetique/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/buildDrawerApp.dart';
import '../../widgets/orders/buildOrderItem.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    var _userId = AuthData().getUserId;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Oders',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: BuildDrawerApp(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('id_user', isEqualTo: _userId)
            .snapshots(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurrent!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) =>
                    dataSnapshot.data.docs.length == 0
                        ? Center(
                            child: Text(
                              'You don\'t have order - let add some item in cart!',
                            ),
                          )
                        : ListView.builder(
                            itemCount: dataSnapshot.data.docs.length,
                            itemBuilder: (ctx, index) => BuildOrderItem(
                              dataSnapshot.data.docs[index],
                            ),
                          ),
              );
            }
          }
        },
      ),
    );
  }
}
