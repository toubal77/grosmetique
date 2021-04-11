import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../profile_screen.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  var newpassword;

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();
    try {
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance.currentUser
          .updatePassword(newpassword)
          .then((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Seccus!"),
              content: Text('Succesfull changed password'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return ProfileScreen();
                        },
                      ),
                    );
                  },
                  child: Text('okey'),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Fieled"),
              content: Text("Password can't be changed Contact Admin"),
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
        );
      });
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            child: const Text(
              'Change Your Password',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            //width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.26,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Password is too short!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newpassword = value;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Password do not match!';
                        }
                        return null;
                      },
                    ),
                    Spacer(),
                    _isLoading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: _submitForm,
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    /*RaisedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
