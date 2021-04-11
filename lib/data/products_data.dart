import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  String imageUrl;
  double price;
  String categories;
  String marques;
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.categories,
    this.marques,
  });
}

class Products with ChangeNotifier {
  List<Product> prods = [];

  Product findById(String id) {
    return prods.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(Product product, String productDoc) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productDoc)
          .update({
        'id': DateTime.now().toString(),
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'categorie': product.categories,
        'marque': product.marques,
        'price': product.price,
      });
      print('product  updeted with seccus');
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'id': DateTime.now().toString(),
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'categorie': product.categories,
        'marque': product.marques,
        'price': product.price,
      });
      print('product  added with seccus');
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
