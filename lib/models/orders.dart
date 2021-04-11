import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../models/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final bool confirmed;
  final String username;
  final String uidUser;
  final String email;
  final String phone;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
    @required this.confirmed,
    @required this.username,
    @required this.uidUser,
    @required this.email,
    @required this.phone,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  // ignore: unused_field
  List<OrderItem> _allorders = [];
  final String userId;
  Orders(this.userId, this._orders);
  List<List<QueryDocumentSnapshot>> _prodAllOrder = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future valideOrder(QueryDocumentSnapshot orderItem) async {
    try {
      print(orderItem['id']);
      print(orderItem['dateTime']);
      print(orderItem['confirmed']);
      print(orderItem['username']);
      print(orderItem['phone']);
      var snapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      var _products = snapshot.docs;
      var _prod = _products.firstWhere(
          (prod) => prod.data()['dateTime'] == orderItem['dateTime']);
      var _idOrderProd = _prod.id;
      print(_idOrderProd);
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(_idOrderProd)
          .update({
        'confirmed': true,
      });

      print('Order validate');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future fetchAndSetAllOrders() async {
    List<String> allIdUsers = [];
    try {
      var snapshot = await FirebaseFirestore.instance.collection('users').get();
      var _users = snapshot.docs;
      print('get all uid users');
      for (int i = 0; i < _users.length; i++) {
        allIdUsers.add(_users[i]['id_user']);
        print(_users[i]['id_user']);
      }
      print('get all commandes with reserved egal to false');
      for (int i = 0; i < allIdUsers.length; i++) {
        var snapshot1 = await FirebaseFirestore.instance
            .collection('orders')
            .doc(allIdUsers[i])
            .collection('prod_order')
            .where('reserved', isEqualTo: false)
            .get();
        _prodAllOrder.add(snapshot1.docs);
        print(snapshot1.docs);
      }
      notifyListeners();
      return _prodAllOrder;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      final timesTamp = DateTime.now();
      var _userId = AuthData().getUserId;
      var _username = await AuthData().getUserUsername;
      var _phoneUser = await AuthData().getUserPhone;
      var _emailUser = await AuthData().getUserEmail;
      await FirebaseFirestore.instance.collection('orders').add(
            ({
              'id': timesTamp,
              'dateTime': timesTamp.toIso8601String(),
              'amount': total,
              'username': _username,
              'email': _emailUser,
              'phone': _phoneUser,
              'confirmed': false,
              'id_user': _userId,
              'products': cartProducts
                  .map((cp) => {
                        'id': cp.id,
                        'title': cp.title,
                        'quantity': cp.quantity,
                        'price': cp.price,
                      })
                  .toList(),
            }),
          );

      _orders.insert(
        0,
        OrderItem(
          id: timesTamp.toIso8601String(),
          amount: total,
          username: _username,
          email: _emailUser,
          phone: _phoneUser,
          products: cartProducts,
          uidUser: _userId,
          dateTime: timesTamp,
          confirmed: false,
        ),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
