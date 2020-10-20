import 'dart:io';

import 'package:church_locator/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as basename;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddChurchScreen extends StatefulWidget {
  static final String routeName = '/addchurchScreen';
  @override
  _AddChurchScreenState createState() => _AddChurchScreenState();
}

class _AddChurchScreenState extends State<AddChurchScreen> {
  File _file;
  bool _isLoading = false;
  String userId, _churchName, _fullAddress, _churchState, _lga;
  TextEditingController _nametextEditingController =
      new TextEditingController();
  TextEditingController _addresstextEditingController =
      new TextEditingController();
  TextEditingController _citytextEditingController =
      new TextEditingController();
  TextEditingController _lgatextEditingController = new TextEditingController();
  static SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  Future getFiles() async {
    final file = await picker.getImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _file = File(file.path);
      });
    }
  }

  void uploadFile(filePath) async {
    String fileName = basename.join(filePath.path);

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_churchState);
      setState(() {
        _isLoading = true;
      });

      try {
        FormData formData = new FormData.fromMap({
          "userId": userId,
          "churchName": _churchName,
          "address": _fullAddress,
          "city": _churchState,
          "lga": _lga,
          "file":
              await MultipartFile.fromFile(filePath.path, filename: fileName)
        });

        Response response = await Dio().post(
            'http://churchlocates.com/apiTest/upload.php',
            data: formData);

        print("file upload response : $response");

        showSnackBarMsg(response.data['message']);

        setState(() {
          _isLoading = false;
          _file = null;
          _nametextEditingController.clear();
          _addresstextEditingController.clear();
          _citytextEditingController.clear();
          _lgatextEditingController.clear();
        });
      } catch (e) {
        print("Exeception caught : $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void showSnackBarMsg(String msg) {
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('userId') == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    } else {
      setState(() {
        userId = sharedPreferences.getString('userId');
      });
      print(userId);
    }
  }

  @override
  void dispose() {
    _nametextEditingController.dispose();
    _addresstextEditingController.dispose();
    _citytextEditingController.dispose();
    _lgatextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Church',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          RaisedButton(
              color: Colors.orange,
              onPressed: () => uploadFile(_file),
              child: Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                _isLoading
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.blue[200],
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      )
                    : SizedBox.shrink(),
                GestureDetector(
                  onTap: getFiles,
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[300],
                    child: _file == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 120,
                          )
                        : Image(
                            image: FileImage(_file),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: _nametextEditingController,
                          style: TextStyle(fontSize: 18.0),
                          validator: (input) => input.trim().isEmpty
                              ? 'Church name required'
                              : null,
                          onSaved: (input) => _churchName = input,
                          decoration: InputDecoration(
                            labelText: 'Church Name',
                            //labelStyle: TextStyle(color: Colors.orange),
                          ),
                        ),
                        TextFormField(
                          controller: _addresstextEditingController,
                          style: TextStyle(fontSize: 18.0),
                          validator: (input) => input.trim().isEmpty
                              ? 'Church address required'
                              : null,
                          onSaved: (input) => _fullAddress = input,
                          decoration: InputDecoration(
                              labelText: 'Full Address',
                              //labelStyle: TextStyle(color: Colors.orange),
                              suffixIcon: Icon(
                                Icons.location_searching,
                                color: Colors.orange,
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 180,
                                child: TextFormField(
                                  controller: _citytextEditingController,
                                  style: TextStyle(fontSize: 18.0),
                                  validator: (input) => input.trim().isEmpty
                                      ? 'City is required'
                                      : null,
                                  onSaved: (input) => _churchState = input,
                                  decoration: InputDecoration(
                                    labelText: 'City',
                                    // labelStyle: TextStyle(color: Colors.orange),
                                  ),
                                ),
                              ),
                              Container(
                                width: 180,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    controller: _lgatextEditingController,
                                    style: TextStyle(fontSize: 18.0),
                                    validator: (input) => input.trim().isEmpty
                                        ? 'Local Government is required'
                                        : null,
                                    onSaved: (input) => _lga = input,
                                    decoration: InputDecoration(
                                      labelText: 'LGA',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
