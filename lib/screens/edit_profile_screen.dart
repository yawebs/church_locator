import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:church_locator/screens/login_screen.dart';
import 'package:church_locator/screens/profile_screen.dart';
import 'package:church_locator/services/auths_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as basename;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  static final String routeName = '/editprofileScreen';
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File _file;
  final picker = ImagePicker();
  SharedPreferences sharedPreferences;
  bool _isLoading = false;
  String userId;
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  Future getImage() async {
    final file = await picker.getImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _file = File(file.path);
      });
    }
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

  void uploadProfile(filePath) async {
    String filename = basename.join(filePath.path);
    setState(() {
      _isLoading = true;
    });
    try {
      FormData formData = new FormData.fromMap({
        'userId': userId,
        'file': await MultipartFile.fromFile(filePath.path, filename: filename),
      });
      Response response = await Dio()
          .post('http://churchlocates.com/apiTest/profile.php', data: formData);
      showSnackBarMsg(response.data['message']);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print("Error" + error.toString());
      showSnackBarMsg(error.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: () => 'Invert Colors',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    child: _file == null
                        ? FutureBuilder(
                            future: AuthServices.getProfileImage(userId),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return CircleAvatar(
                                  backgroundImage: snapshot.data['imageUrl'] ==
                                          0
                                      ? AssetImage('assets/images/avatar.jpg')
                                      : CachedNetworkImageProvider(
                                          snapshot.data['imageUrl']),
                                );
                              }
                            },
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(_file),
                          ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Colors.orange,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundColor: Colors.black38,
                        child: IconButton(
                          onPressed: getImage,
                          icon: Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () => uploadProfile(_file),
                child: Container(
                  width: 70.0,
                  child: Row(
                    children: <Widget>[
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text('Save'),
                      Icon(
                        Icons.save,
                        size: 20.0,
                        color: Colors.orange,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child: FutureBuilder(
                    future: AuthServices.getProfileImage(userId),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Form(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50.0,
                                    ),
                                    Text('ReadOnly'),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.orange,
                                          ),
                                          hintText: snapshot.data['firstName']),
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          enabled: false,
                                          suffixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.orange,
                                          ),
                                          hintText: snapshot.data['lastName']),
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          enabled: false,
                                          suffixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.orange,
                                          ),
                                          hintText: snapshot.data['userEmail']),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
