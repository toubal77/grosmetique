import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grosmetique/screens/admin/detail_all_order.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllOrders extends StatefulWidget {
  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Oders',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('confirmed', isEqualTo: false)
            .snapshots(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child:
                    Text('An error occurren!' + dataSnapshot.error.toString()),
              );
            } else {
              return dataSnapshot.data.docs.length == 0
                  ? Center(
                      child: Text(
                          'You don\'t have orders in database to examined'),
                    )
                  : ListView.builder(
                      itemCount: dataSnapshot.data.docs.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => DetailAllOrder(
                                dataSnapshot.data.docs[index],
                              ),
                            ),
                          );
                        },
                        child: GestureDetector(
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            child: Container(
                              child: ListTile(
                                title: Text(
                                  '\DA${dataSnapshot.data.docs[index]['amount'].toStringAsFixed(2)}',
                                ),
                                subtitle: Text(
                                  timeago
                                      .format(DateTime.tryParse(dataSnapshot
                                          .data.docs[index]['dateTime']
                                          .toString()))
                                      .toString(),
                                ),
                                trailing: Icon(
                                  Icons.verified,
                                  color: dataSnapshot.data.docs[index]
                                          ['confirmed']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
              // return Consumer<Orders>(
              //   builder: (ctx, orderData, child) => orderData.orders.length == 0
              //       ? Center(
              //           child: Text(
              //               'You don\'t have orders in database to examined'),
              //         )
              //       : ListView.builder(
              //           itemCount: orderData.orders.length,
              //           itemBuilder: (ctx, index) => GestureDetector(
              //             onTap: () {
              //               Navigator.of(context).push(
              //                 MaterialPageRoute(
              //                   builder: (ctx) => DetailAllOrder(
              //                     orderData.orders[index],
              //                   ),
              //                 ),
              //               );
              //             },
              //             child: GestureDetector(
              //               child: Card(
              //                 margin: const EdgeInsets.all(10),
              //                 child: Container(
              //                   child: ListTile(
              //                     title: Text(
              //                       '\DA${orderData.orders[index].amount.toStringAsFixed(2)}',
              //                     ),
              //                     subtitle: Text(
              //                       DateFormat('dd/MM/yyyy hh:mm').format(
              //                           orderData.orders[index].dateTime),
              //                     ),
              //                     trailing: Icon(
              //                       Icons.verified,
              //                       color: orderData.orders[index].confirmed
              //                           ? Colors.green
              //                           : Colors.red,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              // );
            }
          }
        },
      ),
    );
  }
}
