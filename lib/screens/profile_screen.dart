import 'package:cached_network_image/cached_network_image.dart';
import 'package:church_locator/screens/add_church_screen.dart';
import 'package:church_locator/screens/edit_profile_screen.dart';
import 'package:church_locator/screens/front_screen.dart';
import 'package:church_locator/screens/login_screen.dart';
import 'package:church_locator/screens/verification_info_screen.dart';
import 'package:church_locator/services/auths_services.dart';
import 'package:church_locator/utilities/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  String _userId;
  var imageUrl;
  bool verified = false;

  SharedPreferences sharedPreferences;
  @override
  void initState() {
    // getProfileImage();
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('userId') == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        ),
      );
    } else {
      setState(() {
        _userId = sharedPreferences.getString('userId');
      });
    }
    try {
      final imageLink = await AuthServices.getProfileImage(_userId);
      print(imageLink);
      setState(() {
        imageUrl = imageLink['imageUrl'];
      });
    } catch (error) {}
  }

  // getProfileImage() async {
  //   try {
  //     final image = await AuthServices.getProfileImage(_userId);
  //     if (image != null) {
  //       setState(() {
  //         imageUrl = image;
  //       });
  //     }
  //   } catch (error) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: NavDrawer(
        imageUrl: imageUrl,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder(
                    future: AuthServices.getProfileImage(_userId),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        imageUrl = snapshot.data['imageUrl'];
                        if (int.tryParse(snapshot.data['verified']) == 1) {
                          verified = true;
                        }
                        return Column(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                backgroundImage: snapshot.data['imageUrl'] == 0
                                    ? AssetImage('assets/images/avatar.jpg')
                                    : CachedNetworkImageProvider(
                                        snapshot.data['imageUrl'],
                                      ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  int.tryParse(snapshot.data['verified']) == 1
                                      ? Image.asset(
                                          'assets/images/verification2.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      : SizedBox(
                                          child: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                  Text(
                                    snapshot.data['firstName'] +
                                        ' ' +
                                        snapshot.data['lastName'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
            FlatButton(
              color: Colors.white,
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProfileScreen.routeName),
              child: Container(
                width: 50.0,
                child: Row(
                  children: <Widget>[
                    Text('Edit'),
                    Icon(
                      Icons.edit,
                      size: 20.0,
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
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            height: 40.0,
                            width: 40.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.verified_user,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          title: Text('Verification Status'),
                          trailing: IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => VerificationInfoScreen(
                                  verification: verified,
                                  userId: _userId,
                                ),
                              ),
                            ),
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 40.0,
                            width: 40.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.file_upload,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          title: Text('Add Church'),
                          trailing: IconButton(
                            onPressed: () => verified == true
                                ? Navigator.of(context)
                                    .pushNamed(AddChurchScreen.routeName)
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => VerificationInfoScreen(
                                          verification: verified,
                                          userId: _userId,
                                        ))),
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 40.0,
                            width: 40.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          title: Text('Search Church'),
                          trailing: IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => FrontPageScreen(),
                              ),
                            ),
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 40.0,
                            width: 40.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.report,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          title: Text('Report Location'),
                          trailing: IconButton(
                            onPressed: () => '',
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 40.0,
                            width: 40.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          title: Text('Report User'),
                          trailing: IconButton(
                            onPressed: () => '',
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
