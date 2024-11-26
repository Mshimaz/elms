class Subject {
  final int id;
  final String title;
  final String description;
  final String image;

  Subject({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
}
