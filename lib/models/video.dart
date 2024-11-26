class Video {
  final int id;
  final String title;
  final String description;
  final String videoType;
  final String videoUrl;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoType,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoType: json['video_type'],
      videoUrl: json['video_url'],
    );
  }
}
