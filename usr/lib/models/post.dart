class Post {
  final String id;
  final String authorName;
  final String content;
  final int likes;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.authorName,
    required this.content,
    required this.likes,
    required this.timestamp,
  });
}
