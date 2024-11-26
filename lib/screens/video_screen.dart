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
    // Setting up youtube cintroller
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.video.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 200,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
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
          ),
        ).animate().fade(duration: 800.ms, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
