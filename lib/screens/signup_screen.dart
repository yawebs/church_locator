import 'package:church_locator/models/http_exception.dart';
import 'package:church_locator/screens/login_screen.dart';
import 'package:church_locator/services/auths_services.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static final String pageRoute = "/signup";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  String _firstName, _lastName, _email, _password;
  void _setupShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  _showErrorMessage(String message) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Signup Failed"),
              content: Text(message),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Dismiss"),
                ),
              ],
            ));
  }

  _onSumbited() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });
      try {
        await AuthServices.signUpUser(
            context, _firstName, _lastName, _email, _password);
      } on HttpException catch (error) {
        _showErrorMessage(error.toString());
      } catch (e) {
        _showErrorMessage(
            "Something went wrong, please check your network and try again");
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
                          labelText: "First Name",
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'First name is required'
                            : null,
                        onSaved: (input) => _firstName = input,
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
                          labelText: "Last Name",
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? "Last name is required"
                            : null,
                        onSaved: (input) => _lastName = input,
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
                          labelText: "Email Address",
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (input) {
                          if (input.trim().isEmpty) {
                            return 'email must not be empty';
                          } else if (!input.contains('@')) {
                            return 'Please Enter a valid mail';
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
                            )),
                        obscureText: _showPassword == true ? true : false,
                        validator: (input) => input.trim().isEmpty
                            ? 'password is required'
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
                              onPressed: _onSumbited,
                              child: Text(
                                "Signup",
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
                          .pushNamed(LoginScreen.pageRoute),
                      child: Container(
                        child: Text(
                          "Already Have Account? Login",
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
