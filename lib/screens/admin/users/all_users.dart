import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grosmetique/widgets/admin/buildUserListTile.dart';
import 'addUser_screen.dart';

class AllUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
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
              Navigator.of(context).pushNamed(AddUserScreen.routeName);
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final docs = snapshot.data.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, index) => Column(
                children: <Widget>[
                  BuildUserListTile(docs[index].data()),
                  Divider(),
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
