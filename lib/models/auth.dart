import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class AuthData with ChangeNotifier {
  String get getUserId {
    String _userId = FirebaseAuth.instance.currentUser?.uid;
    return _userId;
  }

  Stream<String> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  get getUserEmail {
    String _userEmail = FirebaseAuth.instance.currentUser.email;
    return _userEmail;
  }

  Future<bool> get getUserAdmin async {
    DocumentSnapshot _userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(getUserId)
        .get();

    return _userData['status_admin'];
  }

  // ignore: missing_return
  Future<String> get getUserPhone async {
    try {
      DocumentSnapshot _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(getUserId)
          .get();

      return _userData['phone'].toString();
    } catch (err) {
      print(err);
    }
  }

  // ignore: missing_return
  Future<String> get getUserUsername async {
    try {
      DocumentSnapshot _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(getUserId)
          .get();

      return _userData['username'].toString();
    } catch (err) {
      print(err);
    }
  }
}
