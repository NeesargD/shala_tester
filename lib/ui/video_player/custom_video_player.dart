import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';

import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    this.videoUrl = 'Chewie Demo',
  }) : super(key: key);

  final String videoUrl;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  //TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // print(widget.title);
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    // _videoPlayerController1 = VideoPlayerController.network(widget.title);
    _videoPlayerController1 = VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4');
    _videoPlayerController2 = VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
    await Future.wait([_videoPlayerController1.initialize(), _videoPlayerController2.initialize()]);
    _createChewieController();
    _chewieController!.enterFullScreen();
    _chewieController!.play();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: screenWidth(context: context),
              height: screenHeight(context: context, percent: 0.38),
              child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
            ),
          ),
          /*TextButton(
            onPressed: () {
              _chewieController?.enterFullScreen();
            },
            child: const Text('Fullscreen'),
          ),*/
          /*Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.android;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Android controls"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.iOS;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("iOS controls"),
                  ),
                ),
              )
            ],
          ),*/
        ],
      ),
    );
  }
}
