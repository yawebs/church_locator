import 'package:file_picker/file_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ChewieVideo extends StatefulWidget {
  final bool looping;
  final VideoPlayerController videoPlayerController;
  ChewieVideo({@required this.videoPlayerController, this.looping, Key key})
      : super(key: key);
  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}

class _ChewieVideoState extends State<ChewieVideo> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 16 / 11,
        looping: widget.looping,
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  void dispose() {
    _chewieController.dispose();
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
