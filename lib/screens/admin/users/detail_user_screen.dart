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
  // ignore: non_constant_identifier_names
  var _status_admin;
  String _status;
  var valuesUser = {
    'id_user': '',
    'username': '',
    'email': '',
    'address': '',
    'phone': '',
    'status_admin': '',
  };
  // ignore: non_constant_identifier_names
  void EditStatusAdmin(String valuesUserStatus) async {
    try {
      if (valuesUserStatus == "true") {
        _status_admin = false;
      } else {
        _status_admin = true;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(valuesUser['id_user'])
          .set(
        {
          'id_user': valuesUser['id_user'],
          'email': valuesUser['email'],
          'username': valuesUser['username'],
          'phone': valuesUser['phone'],
          'address': valuesUser['address'],
          'status_admin': _status_admin,
        },
      ).then(
        (_) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("User Edit"),
              content: Text('User status admin edit with success.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('okey'),
                ),
              ],
            );
          },
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An error Occurred'),
            content: Text("User status admin can'\'t be change "),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print(e);
    }
  }

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
        valuesUser['status_admin'] = snapshot.data()['status_admin'].toString();

        valuesUser['status_admin'] == 'true'
            ? _status = "is admin"
            : _status = "is't admin";
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
      body: SingleChildScrollView(
        child: Column(
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
            DetailUser('status', _status),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        EditStatusAdmin(valuesUser['status_admin']);
                      },
                      child: Text(
                        valuesUser['status_admin'] == "true"
                            ? 'suscriber'
                            : 'admin',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
                text ?? 'default value',
                //  overflow: TextOverflow.ellipsis,
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
