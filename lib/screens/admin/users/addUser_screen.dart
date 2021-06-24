import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:grosmetique/screens/profile_screen.dart';

class AddUserScreen extends StatefulWidget {
  static final routeName = '/add_user';
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUserScreen> {
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confPasswordFocusNode = FocusNode();
  final _idUserController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  bool status_admin = false;
  final _form = GlobalKey<FormState>();
  var _valuesForm = {
    'id_user': '',
    'username': '',
    'e-mail': '',
    'phone': '',
    'address': '',
    'password': '',
  };
  var _isInit = true;
  var _edit = false;

  void didChangeDependencies() async {
    if (_isInit) {
      final userId = ModalRoute.of(context).settings.arguments as String;
      if (userId != null) {
        _edit = true;
        var snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        _idUserController.text = snapshot.data()['id_user'];
        _usernameController.text = snapshot.data()['username'];
        _emailController.text = snapshot.data()['email'];
        _phoneController.text = snapshot.data()['phone'];
        _addressController.text = snapshot.data()['address'];
        status_admin = snapshot.data()['status_admin'];
        _valuesForm['e-mail'] = _emailController.text;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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
      if (_edit == false) {
        UserCredential _userData =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _valuesForm['e-mail'],
          password: _valuesForm['password'],
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userData.user.uid)
            .set(
          {
            'id_user': _userData.user.uid,
            'email': _valuesForm['e-mail'],
            'username': _valuesForm['username'],
            'phone': _valuesForm['phone'],
            'address': _valuesForm['address'],
            'status_admin': false,
          },
        ).then(
          (_) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("User Added"),
                content:
                    Text('User ${_valuesForm['username']} added with success.'),
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
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_idUserController.text)
            .set(
          {
            'id_user': _idUserController.text,
            'email': _valuesForm['e-mail'],
            'username': _valuesForm['username'],
            'phone': _valuesForm['phone'],
            'address': _valuesForm['address'],
            'status_admin': status_admin,
          },
        ).then(
          (_) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("User Edit"),
                content:
                    Text('User ${_valuesForm['username']} edit with success.'),
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
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      if (err.toString().contains('EMAIL_EXISTS')) {
        message = 'This email address is already in use.';
      } else if (err.toString().contains('INVALID_EMAIL')) {
        message = 'This is not a valid email  address.';
      } else if (err.toString().contains('WEAK_PASSWORD')) {
        message = 'This password is to weak.';
      } else if (err.toString().contains('EMAIL_NOT_FOUND')) {
        message = 'Could not find a user with that email.';
      } else if (err.toString().contains('INVALID_PASSWORD')) {
        message = 'Invalid password.';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An error Occurred'),
            content: Text(message),
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
      print(err);
      // throw err;
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
      // throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New User',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
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
              _edit == false
                  ? TextFormField(
                      decoration: InputDecoration(labelText: 'E-mail'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocusNode,
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
                    )
                  : FocusScope(
                      node: new FocusScopeNode(),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                        ),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
                        enabled: false,
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
                    ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phome'),
                controller: _phoneController,
                focusNode: _phoneFocusNode,
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
                decoration: InputDecoration(labelText: 'address'),
                controller: _addressController,
                focusNode: _addressFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 5)
                    return 'Please enter a valid address.';

                  return null;
                },
                onSaved: (value) {
                  _valuesForm['address'] = value;
                },
              ),
              if (_edit == false)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_confPasswordFocusNode);
                  },
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 6)
                      return 'Password must be at least 6 characters long.';

                    return null;
                  },
                  onSaved: (value) {
                    _valuesForm['password'] = value;
                  },
                ),
              if (_edit == false)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  focusNode: _confPasswordFocusNode,
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text)
                      return 'Password do not match!';

                    return null;
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
