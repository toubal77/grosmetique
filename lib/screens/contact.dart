import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactUs extends StatefulWidget {
  // @override
  // void initState() {
  //   getData();

  //   super.initState();
  // }

  // Future getData() async {
  //   var _time = DateTime.now().toString();
  //   // List _products = [];
  //   var url = Uri.parse(
  //       'https://toubal-zineddine.000webhostapp.com/orders/add_order.php');
  //   var response = await http.post(url, body: {
  //     'user_id': '2',
  //     'order_num': '123456',
  //     'order_date': _time,
  //   });
  //   if (response.statusCode == 200) {
  //     print("kolch normal");
  //     print(response.body);
  //     final _fetchProd = jsonDecode(response.body);
  //     // print("users");
  //     // print(_fetchProd['users'][0]['address']);
  //     // print(_fetchProd['users'][1]['name']);
  //     // print(_fetchProd['users'][1]['status_admin']);
  //     // print(_fetchProd['users'][0]['status_admin']);
  //     // print(_fetchProd['status']);
  //     // print(_fetchProd['nbr']);
  //     // print(_fetchProd['message']);
  //     // print(_fetchProd['users'][2]['phone']);
  //   } else {
  //     print("mchi normal");
  //     print(response.body);
  //   }
  // }

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    getData();

    super.initState();
  }

  Future getData() async {
    var _time = DateTime.now().toString();
    // List _products = [];
    // var url = Uri.parse(
    //     'https://toubal-zineddine.000webhostapp.com/orders/add_order.php');
    // var response = await http.post(url, body: {
    //   'user_id': '2',
    //   'order_num': '123456',
    //   'order_date': _time,
    // });
    var url = Uri.parse(
        'https://34c66b07cf190f5fd9797f23b918cb6e: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@essai-api.myshopify.com/admin/api/2021-04/products.json');
    var response = await http.post(url);
    if (response.statusCode == 200) {
      print("kolch normal");
      print(response.body);
      final _fetchProd = jsonDecode(response.body);
      // print("users");
      print(_fetchProd['products'][0]['title']);
      print(_fetchProd['prodicts'][0]['id']);
      print(_fetchProd['prodicts'][0]['variants']['price']);
      // print(_fetchProd['users'][1]['status_admin']);
      // print(_fetchProd['users'][0]['status_admin']);
      // print(_fetchProd['status']);
      // print(_fetchProd['nbr']);
      // print(_fetchProd['message']);
      // print(_fetchProd['users'][2]['phone']);
    } else {
      print("mchi normal");
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Contact Us',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text('CONTACTEZ NOUS POUR AVOIR UN COMPTE'),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('PAR TELEPHONE:'),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '07 75 35 19 24 / 05 42 14 96 42',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('OU PAR EMAIL:'),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('ADMIN@GROSMETIQUE.COM'),
          ),
        ],
      ),
    );
  }
}
