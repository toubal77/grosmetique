import 'package:flutter/material.dart';
import 'package:grosmetique/models/orders.dart' as ord;
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailAllOrder extends StatelessWidget {
  final order;

  DetailAllOrder(this.order);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Oders',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'price: \DA${order['amount'].toStringAsFixed(2)}',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              'name: ${order['username']}',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              'phone: ${order['phone']}',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              'email: ${order['email']}',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              'commende le: ' +
                  timeago
                      .format(DateTime.tryParse(order['dateTime'].toString()))
                      .toString(),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.all(3.0),
            child: const Text(
              'Products',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (int i = 0; i < order['products'].length; i++)
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      order['products'][i]['title'],
                    ),
                  ),
                  Text(
                    '${order['products'][i]['quantity']}x \DA${order['products'][i]['price'].toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Provider.of<ord.Orders>(context, listen: false)
                  .valideOrder(order);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Orders Validate!',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            color: Colors.purple,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'Valide',
            ),
          ),
        ],
      ),
    );
  }
}
