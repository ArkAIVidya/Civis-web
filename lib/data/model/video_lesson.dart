class VideoLesson {
  final String id;
  final String title;
  final String description;
  final String videoId;
  final String? playlistId;
  final String thumbnailUrl;

  const VideoLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.videoId,
    this.playlistId,
    required this.thumbnailUrl,
  });
}
