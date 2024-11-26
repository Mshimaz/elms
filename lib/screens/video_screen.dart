import 'package:elms/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;
  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  String videoId = '';
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    // To get Video Id from YouTube
    if (widget.video.videoType == 'YouTube') {
      final uri = Uri.parse(widget.video.videoUrl);
      videoId = uri.queryParameters['v'] ?? '';
    } else {
      // To get Video Id from Vimeo
      final uri = Uri.parse(widget.video.videoUrl);
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    }
    // Setting up youtube controller
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    // To detect full-screen mode changes
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          isFullScreen = _controller.value.isFullScreen;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: widget.video.videoType == 'YouTube'
                      // YouTube Player
                      ? YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                        )
                      // Vimeo Player
                      : VimeoPlayer(
                          videoId: videoId,
                        ),
                ).animate().fade(duration: 800.ms, curve: Curves.easeIn),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.video.title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.video.description,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                ),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.video.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.teal,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: widget.video.videoType == 'YouTube'
                      // YouTube Player
                      ? YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                        )
                      // Vimeo Player
                      : VimeoPlayer(
                          videoId: videoId,
                        ),
                ).animate().fade(duration: 800.ms, curve: Curves.easeIn),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.video.title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.video.description,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
