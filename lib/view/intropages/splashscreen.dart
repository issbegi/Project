import 'package:flutter/material.dart';
import 'package:urbanfootprint/view/intropages/login.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/videos/splashscreen.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            _navigateToHomePage();
          }
        });
        _controller.play();
      });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: false,
      allowPlaybackSpeedChanging: false,
      allowFullScreen: false,
      showControls: false,
    );
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: _controller.value.isInitialized
            ? Chewie(
                controller: _chewieController,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}