import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:grosmetique/models/auth.dart';
import '../../profile_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  var _isLoading = false;
  var _isInit = true;
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _valuesForm = {
    'username': '',
    'e-mail': '',
    'phone': '',
    'address': '',
    'status_admin': false,
  };

  @override
  void didChangeDependencies() {
    if (_isInit) fetchDataUser();
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (_isInit) fetchDataUser();
    _isInit = false;
    super.initState();
  }

  void fetchDataUser() async {
    setState(() {
      _isLoading = true;
    });
    var _userId = AuthData().getUserId;
    var _userData =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();
    _usernameController.text = _userData['username'];
    _phoneController.text = _userData['phone'];
    _emailController.text = _userData['email'];
    _addressController.text = _userData['address'];
    _valuesForm['status_admin'] = _userData['status_admin'];

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _confirmForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm'),
        content: Text(
          'Your Information:' +
              '\n' +
              ' username:${_valuesForm['username']}' +
              '\n' +
              'email:${_valuesForm['e-mail']}' +
              '\n' +
              'phone:${_valuesForm['phone']}' +
              '\n' +
              'address:${_valuesForm['address']} ',
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Edit',
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              'Confirm',
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
            onPressed: () async {
              await _saveForm();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ProfileScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    try {
      var _userId = AuthData().getUserId;
      await FirebaseFirestore.instance.collection('users').doc(_userId).set(
        {
          'id_user': _userId,
          'email': _valuesForm['e-mail'],
          'username': _valuesForm['username'],
          'phone': _valuesForm['phone'],
          'address': _valuesForm['address'],
          'status_admin': _valuesForm['status_admin'],
        },
      ).then(
        (_) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Infomation Edit"),
              content: Text(
                  '${_valuesForm['username']} You edit you profile with success.'),
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
    } catch (err) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An error Occurred'),
            content: Text(err.message),
            actions: [
              TextButton(
                child: Text("Closee"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _confirmForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      // initialValue: _valuesForm['username'],
                      decoration: InputDecoration(labelText: 'Username'),
                      textInputAction: TextInputAction.next,
                      controller: _usernameController,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 4)
                          return 'Please enter at least 4 characters';

                        return null;
                      },
                      onSaved: (value) {
                        _valuesForm['username'] = value;
                      },
                    ),
                    TextFormField(
                      //  initialValue: _valuesForm['e-mail'],
                      decoration: InputDecoration(labelText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@'))
                          return 'Please enter a valid email address.';

                        return null;
                      },
                      onSaved: (value) {
                        _valuesForm['e-mail'] = value;
                      },
                    ),
                    TextFormField(
                      //   initialValue: _valuesForm['phone'],
                      decoration: InputDecoration(labelText: 'Phome'),
                      textInputAction: TextInputAction.next,
                      controller: _phoneController,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_addressFocusNode);
                      },
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty || value.length > 10)
                          return 'Please a valid phone number';
                        if (!value.startsWith('0'))
                          return 'Phone number would start with number 0.';
                        return null;
                      },
                      onSaved: (value) {
                        _valuesForm['phone'] = value;
                      },
                    ),
                    TextFormField(
                      //   initialValue: _valuesForm['address'],
                      decoration: InputDecoration(labelText: 'address'),
                      focusNode: _addressFocusNode,
                      controller: _addressController,
                      validator: (value) {
                        if (value.isEmpty || value.length < 10)
                          return 'Please enter a valid address.';

                        return null;
                      },
                      onSaved: (value) {
                        _valuesForm['address'] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
