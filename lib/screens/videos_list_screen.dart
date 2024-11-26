import 'package:elms/models/video.dart';
import 'package:elms/providers/module_provider.dart';
import 'package:elms/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class VideosListScreen extends StatelessWidget {
  final int moduleId;
  final String moduleTitle;

  const VideosListScreen(
      {super.key, required this.moduleId, required this.moduleTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          moduleTitle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: Provider.of<ModulesProvider>(context, listen: false)
            .fetchVideos(moduleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final videos = Provider.of<ModulesProvider>(context).videos;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (ctx, index) {
                String videoId;
                if (videos[index].videoType == 'YouTube') {
                  final uri = Uri.parse(videos[index].videoUrl);
                  videoId = uri.queryParameters['v'] ?? '';
                } else {
                  // To get Video Id from Vimeo
                  final uri = Uri.parse(videos[index].videoUrl);
                  videoId =
                      uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
                }
                return VideoCard(
                  video: videos[index],
                  videoId: videoId,
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Video Card
class VideoCard extends StatelessWidget {
  final Video video;
  final String videoId;

  const VideoCard({super.key, required this.video, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          video.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(video.description),
        trailing: SizedBox(
          height: 50,
          width: 50,
          child: Stack(
            children: [
              video.videoType == 'YouTube'
                  ? Center(
                      child: Image.network(
                          'https://img.youtube.com/vi/$videoId/0.jpg'))
                  : Center(
                      child:
                          Image.network('https://vumbnail.com/$videoId.jpg')),
              const Center(child: Icon(Icons.play_circle_fill)),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                      video: video,
                    )),
          );
        },
      ),
    ).animate().slide(duration: 500.ms, curve: Curves.easeOut);
  }
}
