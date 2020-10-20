import 'package:chewie/chewie.dart';
import 'package:church_locator/screens/verification_screen.dart';
import 'package:church_locator/utilities/chewievideo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VerificationInfoScreen extends StatefulWidget {
  final bool verification;
  var userId;
  VerificationInfoScreen({@required this.verification, @required this.userId});

  @override
  _VerificationInfoScreenState createState() => _VerificationInfoScreenState();
}

class _VerificationInfoScreenState extends State<VerificationInfoScreen> {
  bool _isLoading = false;

  _buildintro(String text, IconData icon) {
    return Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> getVerificationVideo(var userId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String url = 'http://churchlocates.com/apiTest/getverificationvideo.php';
      FormData formData = FormData.fromMap({'userId': int.tryParse(userId)});
      Response response = await Dio().post(url, data: formData);
      if (response.data['status'] == true) {
        print(response.data['message']);
        return response.data;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/info.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 15),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    height: 100,
                    child: widget.verification == true
                        ? Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/verification2.png',
                                width: 30,
                                height: 30,
                              ),
                              Text(
                                'Verified',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              Text(
                                'Not Verified',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  right: 50,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 70.0,
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/images/verification2.png',
                                width: 30, height: 30),
                            Text(
                              'Verification Process',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 28.0),
                            )
                          ],
                        ),
                        Container(
                          height: 30.0,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              Text(
                                'Introduce yourself via a video',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        _buildintro('Intro video must consist the following..',
                            Icons.check_circle),
                        _buildintro('Your name', Icons.check_circle),
                        _buildintro('Church name', Icons.check_circle),
                        _buildintro(
                            'Your position in Church', Icons.check_circle),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: widget.verification != true
                ? Text(
                    'You are required to do a maximum 2mins video of yourself,introducing yourself,name, church name and position in church, our team will review your video for verification')
                : Text(
                    'Your Account is already verified, you can now upload churches and access advance features on this platform'),
          ),
          widget.verification == true
              ? Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.grey,
                    onPressed: () => '',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Account Already Verified',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.orange,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => VerificationScreen()),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Verify Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
          Expanded(
            child: FutureBuilder(
              future: getVerificationVideo(widget.userId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ChewieVideo(
                    videoPlayerController:
                        VideoPlayerController.network(snapshot.data['message']),
                    looping: true,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
