import 'package:flutter/material.dart';
import 'package:t_blaster/responsive.dart';
import 'package:video_player/video_player.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
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

  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  Future<void> fadeInFadeOut() async {
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
    setState(() {});
  }

  @override
  void initState() {
    fadeInFadeOut();
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    // print(MediaQuery.of(context).size.width);
    Responsive responsive =
        Responsive(context: context, deviceHeight: 867.4, deviceWidth: 411.4);
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
                  Positioned(
                    top: responsive.setHeight(height: 700),
                    left: responsive.setWidth(width: 60),
                    child: FadeTransition(
                      opacity: _fadeInFadeOut,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            responsive.setWidth(width: 300),
                            responsive.setHeight(height: 60),
                          ),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              responsive.setRadius(radius: 12),
                            ), // <-- Radius
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Let's Play",
                          style: TextStyle(
                            fontSize: responsive.setFontSize(fontSize: 20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }
}
