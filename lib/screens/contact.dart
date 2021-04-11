//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class ContactUs extends StatelessWidget {
  // @override
  // void initState() {
  //   getData();

  //   super.initState();
  // }

  // Future getData() async {
  //   var _time = DateTime.now();
  //   List _products = [];
  //   var url = Uri.parse(
  //       'https://toubal-zineddine.000webhostapp.com/products/get_all_products.php');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     print("kolch normal");
  //     print(response.body);
  //     final _fetchProd = jsonDecode(response.body);
  //     print("prods");
  //     print(_fetchProd['products'][0]['categories']);
  //   } else {
  //     print("mchi normal");
  //     print(response.body);
  //   }
  // }

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
