import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grosmetique/home_widget.dart';

import 'package:grosmetique/screens/authScreen/bezierContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:grosmetique/screens/connection_status.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  var _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();
    // ignore: unused_local_variable
    UserCredential _userData;
    try {
      setState(() {
        _isLoading = true;
      });
      if (_authMode == AuthMode.Login) {
        _userData = await _auth.signInWithEmailAndPassword(
          email: _authData['email'],
          password: _authData['password'],
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return HomeWidget();
            },
          ),
        );
      }
    } on PlatformException catch (err) {
      // ignore: unused_local_variable
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

      setState(() {
        _isLoading = false;
      });
      print(err);
      // throw err;
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
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

  Widget _entryField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty || value.length < 6) {
                  return 'Password is too short!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _register() {
    return Container(
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'CONTACTEZ NOUS POUR AVOIR UN COMPTE',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              'PAR TELEPHONE:',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              '07 75 35 19 24 / 05 42 14 96 42',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              'OU PAR EMAIL:',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              'ADMIN@GROSMETIQUE.COM',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () => _submitForm(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffd1abbd), Color(0xffb5487e)],
          ),
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        _switchAuthMode();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _authMode == AuthMode.Login
                  ? 'Don\'t have an account ?'
                  : 'You have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              _authMode == AuthMode.Login ? 'Register' : 'Login',
              style: TextStyle(
                color: Color(0xffb5487e),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'GROS',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xffb5487e),
        ),
        children: [
          TextSpan(
            text: 'METIQUE',
            style: TextStyle(
              color: Color(0xffb5487e),
              fontSize: 28,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: Container(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .2),
                          _title(),
                          SizedBox(height: 50),
                          if (_authMode == AuthMode.Login) _entryField(),
                          if (_authMode == AuthMode.Login) SizedBox(height: 20),
                          if (_authMode == AuthMode.Login)
                            _isLoading
                                ? CircularProgressIndicator()
                                : _submitButton(),
                          if (_authMode != AuthMode.Login) _register(),
                          if (_authMode == AuthMode.Login)
                            GestureDetector(
                              onTap: () {
                                _switchAuthMode();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: height * .040,
                          ),
                          _createAccountLabel(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConnextionStatus(),
        ],
      ),
    );
  }
}
