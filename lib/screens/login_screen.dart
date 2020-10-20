import 'dart:io';
import 'dart:math';

import 'package:church_locator/models/http_exception.dart';
import 'package:church_locator/screens/signup_screen.dart';
import 'package:church_locator/services/auths_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final String pageRoute = "/loginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showPassword = true;
  String _email, _password;

  _showErrorDialog(String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Login Failed"),
        content: Text(message),
        actions: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Dismiss"),
          )
        ],
      ),
    );
  }

  void _setupShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  _onSubmitted() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await AuthServices.loginUser(context, _email, _password);
      } on HttpException catch (e) {
        _showErrorDialog(e.toString());
      } catch (e) {
        _showErrorDialog(
            "An error occured please check your network and try again");
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 170.0),
              child: Image.asset(
                "assets/images/logoicon.png",
                width: 80.0,
                height: 80.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 40.0, right: 40.0),
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (input) {
                          if (input.trim().isEmpty) {
                            return 'Email required';
                          } else if (!input.contains('@')) {
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.0, right: 40.0),
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          contentPadding: EdgeInsets.all(10.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              _setupShowPassword();
                            },
                          ),
                        ),
                        obscureText: _showPassword == true ? true : false,
                        validator: (input) => input.trim().isEmpty
                            ? 'Password field required'
                            : null,
                        onSaved: (input) => _password = input,
                      ),
                    ),
                    Container(
                      width: 200.0,
                      height: 70.0,
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0,
                      ),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : RaisedButton(
                              onPressed: _onSubmitted,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              color: Colors.orange,
                            ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(SignupScreen.pageRoute),
                      child: Container(
                        child: Text(
                          "No Account Yet? Signup",
                          style:
                              TextStyle(color: Colors.orange, fontSize: 15.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
