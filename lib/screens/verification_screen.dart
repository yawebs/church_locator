import 'dart:io';

import 'package:church_locator/utilities/chewievideo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http_parser/http_parser.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  File videoFile;
  final picker = ImagePicker();
  Key key;
  SharedPreferences sharedPreferences;
  String _userId;
  final GlobalKey<ScaffoldState> _scalfoltState =
      new GlobalKey<ScaffoldState>();
  bool _isloading = false;

  Future getVideo() async {
    // File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    final filePath = await picker.getVideo(source: ImageSource.gallery);
    if (filePath.path != null) {
      setState(() {
        videoFile = File(filePath.path);
        key = UniqueKey();
      });
    }
    print('video file is $videoFile');
  }

  void showSnackBarMsg(String msg) {
    _scalfoltState.currentState.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('userId') != null) {
      setState(() {
        _userId = sharedPreferences.getString('userId');
      });
    }
  }

  submitVideo(videopath) async {
    String filename = basename(videopath);
    String url = 'http://churchlocates.com/apiTest/verifyvideo.php';
    setState(() {
      _isloading = true;
    });

    if (_userId != null) {
      try {
        FormData formdata = FormData.fromMap({
          'userId': _userId,
          'file': await MultipartFile.fromFile(
            videopath,
            filename: filename,
            contentType: new MediaType('video', 'mp4'),
          ),
        });
        Response response = await Dio().post(url, data: formdata);
        setState(() {
          _isloading = false;
        });
        showSnackBarMsg(response.data['message']);
      } catch (error) {
        showSnackBarMsg(error.toString());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    print("your userId is $_userId");
    return Scaffold(
      key: _scalfoltState,
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => getVideo(),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.video_library,
                      color: Colors.white,
                      size: 100,
                    ),
                    onPressed: getVideo,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50.0),
                    child: Text(
                      'Choose video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          videoFile != null
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ChewieVideo(
                            key: key,
                            videoPlayerController: VideoPlayerController.file(
                              videoFile,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(right: 30, left: 30),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              color: Colors.black,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: _isloading
                                    ? Center(child: CircularProgressIndicator())
                                    : Text(
                                        'Submit Video',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                              onPressed: () => submitVideo(videoFile.path),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Center(
                      child: Text('No Video File Choosen'),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
