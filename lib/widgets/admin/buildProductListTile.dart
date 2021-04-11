import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screens/admin/edit_product_screen.dart';

class BuildProductListTile extends StatelessWidget {
  final prods;
  BuildProductListTile(this.prods);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(prods['title']),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          prods['imageUrl'],
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: prods['id'].toString());
              },
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
              onPressed: () => _deleteProduct(prods['title']),
            ),
          ],
        ),
      ),
    );
  }
}

void _deleteProduct(String deleteTitle) async {
  var snapshot = await FirebaseFirestore.instance.collection('products').get();
  var _prods = snapshot.docs;
  var _idDelete =
      _prods.firstWhere((prod) => prod.data()['title'] == deleteTitle).id;
  await FirebaseFirestore.instance
      .collection('products')
      .doc(_idDelete)
      .delete();
}
