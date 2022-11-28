import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late VideoPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
        "assets/video/backgroundVideoHighlight.mp4");
    await _videoPlayerController.initialize().then(
          (_) => _videoPlayerController.play(),
        );
    await _videoPlayerController.setLooping(true);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: SizedBox(
                        width: _videoPlayerController.value.size.width,
                        height: _videoPlayerController.value.size.height,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: chewieController != null &&
    //             chewieController!.videoPlayerController.value.isInitialized
    //         ? Stack(
    //             children: [
    //               SizedBox.expand(
    //                 child: FittedBox(
    //                   fit: BoxFit.fitHeight,
    //                   child: SizedBox(
    //                     width: _videoPlayerController.value.size.width,
    //                     height: _videoPlayerController.value.size.height,
    //                     child: VideoPlayer(_videoPlayerController),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           )
    //         : Container(),
    //   ),
    // );
  }
}
