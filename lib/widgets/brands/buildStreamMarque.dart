import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'BuildCardStreamMarque.dart';

class BuildStreamMarque extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: 10.0,
          bottom: 7.0,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('marques').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final docs = snapshot.data.docs;
              if (docs.length > 0) {
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) {
                    return BuildCardStreamMarque(docs[index]);
                  },
                );
              } else {
                return Center(
                  child: Text('You don\'t have Marques yet!'),
                );
              }
            }
            if (snapshot.data == null) {
              return Center(
                child: Text('You don\'t have Categories yet!'),
              );
            }
            if (snapshot.error || snapshot.hasError) {
              return Center(
                child: Text(
                    'We have error in server contact devlopper to continue use the app'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
