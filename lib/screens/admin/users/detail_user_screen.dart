import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grosmetique/screens/admin/users/addUser_screen.dart';

class UserDetailScreen extends StatefulWidget {
  static final routeName = '/detail_user';

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  var _isInit = true;
  var valuesUser = {
    'id_user': '',
    'username': '',
    'email': '',
    'address': '',
    'phone': '',
  };
  void didChangeDependencies() async {
    if (_isInit) {
      final userId = ModalRoute.of(context).settings.arguments as String;
      if (userId != null) {
        var snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        valuesUser['id_user'] = userId;
        valuesUser['username'] = snapshot.data()['username'];
        valuesUser['email'] = snapshot.data()['email'].toString();
        valuesUser['phone'] = snapshot.data()['phone'];
        valuesUser['address'] = snapshot.data()['address'];
        setState(() {});
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail User',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddUserScreen.routeName,
                arguments: valuesUser['id_user'],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          DetailUser('username', valuesUser['username']),
          SizedBox(
            height: 15.0,
          ),
          DetailUser('email', valuesUser['email']),
          SizedBox(
            height: 15.0,
          ),
          DetailUser('phone', valuesUser['phone'].toString()),
          SizedBox(
            height: 15.0,
          ),
          DetailUser('address', valuesUser['address']),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AddUserScreen.routeName,
                      arguments: valuesUser['id_user'],
                    );
                  },
                  child: Text(
                    'Edit User',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DetailUser extends StatelessWidget {
  final String title;
  final String text;
  DetailUser(this.title, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Container(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
